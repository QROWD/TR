load <- function() {
  aux = list.files("exp", full.name=TRUE) 
  for(file in aux) source(file);
}

load()

args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("model file hasto be provided (input file).n", call.=FALSE)
}

# init ML model
init_model(args[1])

server <- function(){
  writeLines("Listening...")
  while(TRUE){
    con <- socketConnection(host="localhost", port = 6011, blocking=TRUE,
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
