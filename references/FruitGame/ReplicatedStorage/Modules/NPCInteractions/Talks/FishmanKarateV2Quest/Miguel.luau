 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 5,
    ["NPC"] = "Miguel"
}
local v3 = {
    ["Type"] = "Bring",
    ["ItemName"] = "Carrot",
    ["Ammount"] = 100,
    ["Rewards"] = {
        ["Gear2"] = 1
    }
}
v2.QuestInfo = v3
v2.NotFishman = {
    ["Text"] = "<Color=Red>You dont belong to the seas...",
    ["go"] = "No plz help",
    ["stop"] = "...",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.NotFishmanKarate = {
    ["Text"] = "Your not strong enough with Fishman Karate as a <Color=Blue>Fishman<Color=/>...<AnimateYield=.45>",
    ["go"] = "Nice to meet you!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.NotMaxFishmanKarate = {
    ["Text"] = "Your <Color=Blue>Fishman Karate<Color=/> is too weak right now...<AnimateYield=.45>",
    ["go"] = "Nice to meet you!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.Talk1 = {
    ["Text"] = "Seems like you\'ve come far enough as a <Color=Blue>Fishman<Color=/> from the First Sea...<AnimateYield=.45>",
    ["go"] = "Nice to meet you!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "But your still far away from reaching your true potential as a <Color=Blue>Fishman<Color=/>...<AnimateYield=.45>",
    ["go"] = "I can go get you some!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "We as <Color=Blue>Fishman<Color=/> can evolve into our <Color=Blue>Abyssal Forms<Color=/>, but it seems your too weak right now...",
    ["go"] = "Ok",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = false
}
v2.Talk4 = {
    ["Text"] = "If you can bring me 10 <Color=Blue>Megalodon Teeth<Color=/> as proof of your strength ill pass on my teachings to you.",
    ["go"] = "YES",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = false
}
v2.Talk5 = {
    ["Text"] = "Also your going to need to craft a <Color=Red>Shark Blood Bottle<Color=/> to lure a <Color=Blue>Megalodon<Color=/> from the depths. You can buy a blueprint next to me and head to a blacksmith.",
    ["go"] = "YES",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.BRTalk1 = {
    ["Text"] = "Seems like your strong enough, do you want to learn Abyssal Karate?",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...",
    ["endtext"] = false
}
v2.BRTalk2 = {
    ["Text"] = "I\'ve taught you <Color=Blue>Abyssal Karate<Color=/>, you better win this!",
    ["go"] = "I can go get you some!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = true,
    ["excu"] = function() --[[ Name: excu, Line 90 ]]
        game.ReplicatedStorage.Events.learnStyle:FireServer("Abyssal Karate")
    end
}
v2.NotEnoughGrips = {
    ["Text"] = "<Color=Red>Your not strong enough, eliminate 3 people.",
    ["go"] = "Yes",
    ["stop"] = "...",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.GiveTeeth = {
    ["Text"] = "I did not expect you to come this far, you\'ve proven your strength to me.",
    ["go"] = "Yes",
    ["stop"] = "...",
    ["stoptext"] = "...",
    ["endtext"] = true,
    ["excu"] = function() --[[ Name: excu, Line 109 ]]
        game.ReplicatedStorage.Events.learnStyle:FireServer("Abyssal Karate")
    end
}
v2.AlreadyGave = {
    ["Text"] = "Seems like you\'ve finally reached your true potential as a Fishman!",
    ["go"] = "...",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
v2.learnAbyssalKarate1 = {
    ["Text"] = "Would you like to switch to <Color=Blue>Abyssal Karate<Color=/>?",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = false
}
v2.learnAbyssalKarate2 = {
    ["Text"] = "Ive passed on my teachings to you!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true,
    ["excu"] = function() --[[ Name: excu, Line 134 ]]
        game.ReplicatedStorage.Events.learnStyle:FireServer("Abyssal Karate")
    end
}
return v2