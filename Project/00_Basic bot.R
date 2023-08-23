greeting_bot <- function () {
  username = readline("what's your name:")
  print(paste("Hello", username))
  id_code = readline("May i know your id?:")
  print(paste("Welcome back",username, id_code))
  ages = readline("How old are you?")
  print(paste(username,"is",ages))
  address = readline("Where are you living now:")
  print(paste(address))
  Condition = readline("How are you today:")
  print(paste(Condition))
  print("that's all for today discussion sirs.")
}

greeting_bot()
