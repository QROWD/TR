library("optparse")

option_list = list(
  make_option(c("", "--host"), type="character", default="localhost", 
              help="hostname [default= %default]", metavar="ADDRESS"),
  make_option(c("-p", "--port"), type="integer", default=6011, 
              help="port number [default= %default]", metavar="NUMBER"),
  make_option(c("-m", "--model"), type="character", default=NULL, 
              help="path to model [default= %default]", metavar="path")
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

if (is.null(opt$model)){
  print_help(opt_parser)
  stop("Path to model file must be given!", call.=FALSE)
}


load <- function() {
  aux = list.files("exp", full.name=TRUE) 
  for(file in aux) source(file);
}

load()


# init ML model
init_model(opt$model)

server <- function(){
  writeLines(sprintf("Listening to port %d", opt$port))
  while(TRUE){
    con <- socketConnection(host=opt$host, port = opt$port, blocking=TRUE,
                            server=TRUE, open="r+")
    data <- readLines(con, 1)
   
    args <- unlist(strsplit(data, " "))
    print(paste0("loading data from ", args[1]))
    prediction_task(args[1])
    response <- "done" 
    writeLines(response, con) 
    close(con)
  }
}
server()
