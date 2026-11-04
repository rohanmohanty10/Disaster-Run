 

wait(0.2)
local v1 = require(script.Parent:FindFirstChild("RichText") or script.Parent.Parent)
script.Parent.Enabled = true
local v2 = { script.Parent.Frame.TextBox1, script.Parent.Frame.TextBox2, script.Parent.Frame.TextBox3 }
local v3 = v1:New(v2[1], "He thinks about walking at night to avoid the heat and sun, but based upon how dark it actually was the night before, and given that he has no flashlight, he\'s afraid that he\'ll break a leg or step on a rattlesnake. <Color=Yellow>So, he puts on some sun block, puts the rest in his pocket for reapplication later, <Color=/>brings an umbrella he\'d had in the back of the SUV with him to give him a little shade, pours the windshield wiper fluid into his water bottle in case he gets that desperate, brings his pocket knife in case he finds a cactus that looks like it might have water in it, and heads out in the direction he thinks is right.", {
    ["ContainerVerticalAlignment"] = "Top"
}, false)
local v4 = v3
for v5 = 2, #v2 do
    if v3.Overflown then
        v3 = v1:ContinueOverflow(v2[v5], v3)
    end
end
v4:Animate(true)