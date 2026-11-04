 

local u1 = require(game.ReplicatedStorage.Modules.NPCInteractions.QuestFunctions)
function questHandle(...)
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:QuestHandle(...)
end
local v2 = {
    ["TalkAmmount"] = 4,
    ["NPC"] = "Mei"
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
v2.NotMink = {
    ["Text"] = "<Color=Red>Your not my kin...",
    ["go"] = "No plz help",
    ["stop"] = "...",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.NotElectro = {
    ["Text"] = "Your a mink without <Color=Blue>Electro<Color=/>?? What were you thinking??<AnimateYield=.45>",
    ["go"] = "Nice to meet you!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.NotMaxElectro = {
    ["Text"] = "Your <Color=Blue>Electro<Color=/> is too weak right now...<AnimateYield=.45>",
    ["go"] = "Nice to meet you!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.Talk1 = {
    ["Text"] = "Its been a while since i\'ve met someone of my kin in the Second Sea...<AnimateYield=.45>",
    ["go"] = "Nice to meet you!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = false
}
v2.Talk2 = {
    ["Text"] = "Lets cut to the chase, its been a while since ive had tasty <Color=Orange>Carrots<Color=/> from the First sea...<AnimateYield=.45>",
    ["go"] = "I can go get you some!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = false
}
v2.Talk3 = {
    ["Text"] = "Really you will!? Alright! Bring me <Color=Orange>100 Carrots<Color=/> and in exchange ill tell you how to reach <Color=Blue>Moonlight Ascension<Color=/>...<AnimateYield=.25>",
    ["go"] = "Ok",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = false
}
v2.Talk4 = {
    ["Text"] = "Alright cant wait to eat those <Color=Orange>Carrots<Color=/>!",
    ["go"] = "YES",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.BRTalk1 = {
    ["Text"] = "Seems like your strong enough, do you want to learn Moonlit Electro?",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...",
    ["endtext"] = false
}
v2.BRTalk2 = {
    ["Text"] = "I\'ve taught you <Color=Blue>Moonlit Electro<Color=/>, you better win this!",
    ["go"] = "I can go get you some!",
    ["stop"] = "Bye",
    ["stoptext"] = "...",
    ["endtext"] = true,
    ["excu"] = function() --[[ Name: excu, Line 83 ]]
        game.ReplicatedStorage.Events.learnStyle:FireServer("Moonlit Electro")
    end
}
v2.NotEnoughGrips = {
    ["Text"] = "<Color=Red>Your not strong enough, eliminate 3 people.",
    ["go"] = "Yes",
    ["stop"] = "...",
    ["stoptext"] = "...",
    ["endtext"] = true
}
v2.GiveCarrots = {
    ["Text"] = "Wow you really got me my <Color=Orange>Carrots<Color=/>, and to reach <Color=Blue>Moonlight Ascension<Color=/> head to the <Color=Blue>Island of Zou<Color=/> and interact with the <Color=Blue>Shrine<Color=/> which i\'ve activated for you. Thanks again for the carrots!",
    ["go"] = "Yes",
    ["stop"] = "...",
    ["stoptext"] = "...",
    ["endtext"] = true,
    ["excu"] = function() --[[ Name: excu, Line 102 ]]
        game.ReplicatedStorage.Events.Quest:InvokeServer({ "sulongCarrotQuestEnd" })
    end
}
v2.AlreadyGave = {
    ["Text"] = "Thank you for the carrots, they are so yummy! Make sure to head towards the <Color=Blue>Shrine<Color=/> at the <Color=Blue>Island of Zou<Color=/>!",
    ["go"] = "...",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true
}
v2.learnSulong1 = {
    ["Text"] = "Would you like to switch to <Color=Blue>Moonlit Electro<Color=/>?",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = false
}
v2.learnSulong2 = {
    ["Text"] = "There you go!",
    ["go"] = "Yes",
    ["stop"] = "No",
    ["stoptext"] = "...........................",
    ["endtext"] = true,
    ["excu"] = function() --[[ Name: excu, Line 127 ]]
        game.ReplicatedStorage.Events.learnStyle:FireServer("Moonlit Electro")
    end
}
return v2