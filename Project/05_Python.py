# chatbot for pizza order
def pizza_orders_res():
    pizza_orders = []
    while True:
        pizza_order = input("what kind of pizza menu do you want? ( Press exit for enough )")
        if pizza_order == "exit":
            return pizza_orders
        pizza_orders.append(pizza_order)

#########################

from ast import NotIn
from IPython.utils.path import random
# Game Pao ying chub 
def mini_game_paoyingchub():
    user_rounds = 0
    computer_rounds = 0
    total_rounds = 0
    role_games =["hammer","scissors","paper","Enough"]

    pao_ying_chub = input("Do you want to play game pao ying chub? Y/N")
    if pao_ying_chub == "N":
        return None
    elif pao_ying_chub == "Y":
        while True:
            print(f"Chosing one of these{role_games}.")
            user_decision = input("What do you want to pick up?")
            computer_decision = random.choice(role_games)
            
            if (user_decision == computer_decision):
                print ("Tie")
                total_rounds += 1
            elif (user_decision == "hammer") & (computer_decision == "paper"):
                print ("You Lose")
                computer_rounds += 1
                total_rounds += 1
            elif (user_decision == "paper") & (computer_decision == "hammer"):
                print ("You Win")
                user_rounds += 1
                total_rounds += 1
            elif (user_decision == "scissors") & (computer_decision == "paper"):
                print ("You Win")
                user_rounds += 1
                total_rounds += 1
            elif (user_decision == "hammer") & (computer_decision == "scissors"):
                print ("You Win")
                user_rounds += 1
                total_rounds += 1
            elif (user_decision == "paper") & (computer_decision == "scissors"):
                print ("You Lose")
                computer_rounds += 1
                total_rounds += 1
            elif (user_decision == "scissors") & (computer_decision == "hammer"):
                print ("You Lose")
                computer_rounds += 1
                total_rounds += 1
            elif not(user_decision in role_games):
                print ("Please re-choose again")
            elif (user_decision == "Enough"):
                
                print (computer_rounds)
                print (user_rounds)
                print (total_rounds)
                if (computer_rounds > user_rounds):
                    print(f"You lose {(computer_rounds - user_rounds)} rounds")
                elif (computer_rounds < user_rounds):
                    print(f"You win {abs(computer_rounds - user_rounds)} rounds")
                else: 
                    print(f"You Tie!") 
                break     

   ##########################

## New ATM Class 
class Atm_machines:
    def __init__(self, id, name, bank, balance):
        self.id = id
        self.name = name
        self.bank = bank
        self.balance = balance
    def deposit(self, amt):
        self.deposit_amt = amt
        self.balance += amt
        print(f"You have deposit {(amt)} THB into {self.bank}.")
        print(f"๊Updated New balance {(self.balance + amt)} THB.")
    def withdrawl(self, deduct):
        self.balance -= deduct
        print(f"You have deposit {(deduct)} THB into {self.bank}.")
        print(f"๊Updated New balance {(self.balance + deduct)} THB.") 
    def transaction(self):
        print("###############################")
        print(f"Current Balance is {self.balance}")
        print(f"Thank you for ีusing our service")
        print("##############################")


    


