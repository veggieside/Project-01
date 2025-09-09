/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR name = ""
VAR friend_name = ""
VAR trash = 0
VAR strength = 2
VAR gift = 0
VAR player_health = 10
VAR mailman_health = 20
VAR mailman_strength = 2
VAR time = -1
VAR fought_mailman = 0

-> name_select

== name_select ==
You wake, gasping for air. Your entire body feels cold, and your mind is foggy. What was your name again?

* [Red]
    ~ name = "Red"
    -> bedroom
* [Blue]
    ~ name = "Blue"
    -> bedroom

== bedroom ==
That's right. Your name is {name}. How could you have forgotten?

You look around, taking in your surroundings. You're in bed. This must be your bedroom. You realize your alarm clock is going off, ringing loudly in your ears.
* [Snooze your alarm and go back to bed] -> back_to_sleep
+ [Get out of bed] -> out_of_bed

== back_to_sleep ==
You get in a couple more 'zs before remembering you have obligations.
* [Get out of bed] -> out_of_bed

== out_of_bed ==
Struggling, you climb out of bed. You remember you were supposed to go over to your friend's house today. What was your friend's name again?
* [Steve]
    ~ friend_name = "Steve"
    -> clean
* [Olive]
    ~ friend_name = "Olive"
    -> clean
* [Aqua]
    ~ friend_name = "Aqua"
    -> clean

== clean ==
That's right. {friend_name == "Steve": Your "friend" Steve| } {friend_name != "Steve": Your good friend {friend_name}.| }

{trash < 3: Crap. You have to clean your room before you leave. It's a mess.} {trash == 3: You think your room is clean enough.} You have picked up {trash} pieces of trash

{trash == 3: You feel peckish.}
* [Look under bed] -> under_bed
* [Look on nightstand] -> nightstand
* [Look in closet] -> closet
* {trash == 3} [Go to {friend_name}'s house] -> mailbox
+ {trash == 3} [Grab a snack] -> snack

== under_bed ==
You look under your bed. There's a pile of unfolded laundry that you shoved under there at some point.
* [Fold laundry] -> fold_laundry

== fold_laundry ==
~ trash = trash + 1
You folded your laundry and put it away.
* [Go back] -> clean

== nightstand ==
You look on your nightstand. There are half-filled bottles and cans all over its surface.
* [Throw away trash] -> throw_away

== throw_away ==
~ trash = trash + 1
You pick up the cans and bottles and throw them away.
* [Go back] -> clean

== closet ==
You look in your closet. There are tons of clothes that you didn't bother hanging up.
* [Hang up clothes] -> hang_clothes

== hang_clothes ==
~ trash = trash + 1
You hang up all the clothes nicely.
* [Go back] -> clean

== snack ==
You stop in the kitchen and see a plate of stale tater tots.
+ [Go back] -> clean
* [Eat the tater tots] -> tater_tots

== tater_tots ==
~ strength = strength + 2
You eat the tater tots. They are cold. But you feel stronger for it. Your strength is {strength}.
* [Go to {friend_name}'s house] -> mailbox

== mailbox ==
As you are leaving the house, you remember you ordered {friend_name} a gift! Luckily, the mailman just pulled up to drop it off.
* [Approach mailman] -> mailman
* [Wait for him to deliver your package] -> wait_delivery

== mailman ==
You approach the mailman.
* [Ask kindly for your package] -> ask
* [Fight him for your package] -> mailman_fight

== ask ==
~ gift = gift + 1
"Could I take that package off your hands?"

"Sure, kid."

You obtain your friend's gift!
* [Go to {friend_name}'s house] -> friends_house

== mailman_fight ==
~ fought_mailman = fought_mailman + 1
Readying your fists, you strike the mailman!
~ mailman_health = mailman_health - strength
{ strength < 4: You start to wish you had eaten something before this.| } -> mailman_defense

== mailman_defense ==
Your health is {player_health}

The mailman has {mailman_health} health left.
* [Heal] -> heal
+ [Fight mailman] -> fight

== fight ==
~ mailman_health = mailman_health - strength
You punch the mailman again.

"What the hell, kid?"

{mailman_health > 0: The mailman strikes back.| }

~ player_health = player_health - mailman_strength

* {mailman_health == 0} -> mail_man_defeat
* {player_health == 0} -> death
+ {mailman_health != 0} -> mailman_defense

== heal ==
{friend_name != "Steve": You think about the power of friendship and heal 2 HP} -> healed
{friend_name == "Steve": You try to think about the power of friendship, but it's hard when your only friend is Steve. You can't seem to regain any health.| } -> mailman_defense

== healed ==
~ player_health = player_health + 2
-> mailman_defense

== death ==
You perish at the hands of the mailman. Maybe if you'd have just waited for your package this wouldn't have happened. -> END

== mail_man_defeat ==
You defeat the mailman.

You obtain your friend's gift!
* [Go to {friend_name}'s house] -> friends_house

== wait_delivery ==
You stand inside your porch and wait for your package to be dropped off.

You have waited { advance_time() }.

+ {time < 2} [Wait] -> wait_delivery
* { time == 2 } -> package_delivered

== package_delivered ==
The mailman finally puts your package in the mailbox after an excruciatingly long time.

You obtain your friend's gift!
* [Go to {friend_name}'s house] -> friends_house

== function advance_time ==

    ~ time = time + 1
    
    {
        - time > 3:
            ~ time = 0
    }    
 
    {    
        - time == 0:
            ~ return "1 second"
        
        - time == 1:
            ~ return "2 seconds"
        
        - time == 2:
            ~ return "3 seconds"
    
    }

    
        
    ~ return time
    
    
== friends_house ==
You arrive at {friend_name}'s house.
* [Knock at the door] -> knock
* [Decide you don't want to hang out anymore] -> go_home

== go_home ==
You decide to go home, and return to rotting in your bed -> END

== knock ==
You knock at the door, and {friend_name} answers. {friend_name == "Steve": He gives you a weird look.| }
* {friend_name != "Steve"} -> give_gift
* {friend_name == "Steve"} [Ask Steve what's wrong] -> ask_steve

== give_gift ==
{friend_name} is delighted! You two have a great time hanging out. -> END

== ask_steve ==
He tells you nothing is wrong.
* {fought_mailman == 1} [Realize that mailman was Steve's dad] -> steve_fight
* [Give him the gift] -> give_gift

== steve_fight ==
Steve attacks you for defeating his dad. Why'd you even do that, actually? You could've just waited for your package like a normal person.

* {strength == 4} [Defeat Steve] -> defeat_steve
* {strength < 4} [Perish] -> perish

== defeat_steve ==
You easily defeat Steve thanks to those tater tots you had earlier. Who needs friends, anyways? -> END

== perish ==
You are too hungry to fight back. If only you had eaten earlier... How could you be defeated by a guy named Steve? -> END