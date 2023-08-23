game_paoyingchub <- function () {
  
  game_start <- readline("Do you wanna play games?")
  print(paste(game_start,"lets start then"))
  role_game <- c("hammer","scissor","paper")
  print(role_game)
  game_count <- c("You WIN","You lose","Tie")
  win <- 0
  lose <- 0
  tie <- 0
  
  while (T) {
    user_pick <- readline("Choose one:")
    ai_select <- sample(role_game,1)
    
    if (user_pick == ai_select) {
      print(game_count[3])
      tie = tie + 1
    } else if ((user_pick == "hammer") & ai_select == "paper") {
      print(game_count[2])
      lose = lose + 1
    } else if ((user_pick == "hammer") & ai_select == "scissor") {
      print(game_count[1])
      win = win + 1
    }  else if ((user_pick == "paper") & ai_select == "hammer") {
      print(game_count[1])
      win = win + 1
    }  else if ((user_pick == "paper") & ai_select == "scissor") {
      print(game_count[2])
      lose = lose + 1
    }   else if ((user_pick == "scissor") & ai_select == "hammer") {
      print(game_count[2])
      lose = lose + 1
    }  else if ((user_pick == "scissor") & ai_select == "paper") {
      print(game_count[1])
      win = win + 1
    } 
    if (user_pick == "enough") {
      print ("Thank you for playing")
  
      print((paste("You had won",win)))
      print((paste("You had lose",lose)))
      print((paste("You had tie",tie)))
      break
     
    }
  }   


}
