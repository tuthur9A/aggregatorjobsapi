class JobsController < ApplicationController
  before_action :set_job, only: %i[ show update destroy ]

  # GET /jobs
  def index
    @jobs = Job.all

    render json: @jobs
  end
  # GET /jobs/scrape
  def getScrape
    scraper = ScrapeService.new()
    @actu = scraper.scrapperFreeWork("https://www.free-work.com/fr/tech-it/jobs?query=D%C3%A9veloppeur&remote=full&freshness=less_than_7_days&sort=date&contracts=permanent&contracts=contractor")
    # @actu = scraper.scrapperIndeed("https://fr.indeed.com/jobs?q=d%C3%A9veloppeur&l=T%C3%A9l%C3%A9travail&from=searchOnDesktopSerp")
    # @actu = scraper.scrapperHelloWork("https://www.hellowork.com/fr-fr/emploi/recherche.html?k=D%C3%A9veloppeur&k_autocomplete=&l=France&l_autocomplete=")
    render json: @actu
  end

  def getApiPylote
    @jobs = HTTParty.get("https://api-p.pylote.io/jobs/", headers: {
      "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) bruno/v1.30.1 Chrome/126.0.6478.127 Electron/31.2.1 Safari/537.36",
      "content-type" =>	"application/json; charset=utf-8"
    })
    parsed_jobs = JSON.parse(@jobs.body)
    render json: parsed_jobs.select { |a| a["A distance/Sur place"] == "100% télétravail" || a["remote"] == "100% télétravail" }
  end

  # GET /jobs/1
  def show
    render json: @job
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)

    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:name, :url)
    end
end
