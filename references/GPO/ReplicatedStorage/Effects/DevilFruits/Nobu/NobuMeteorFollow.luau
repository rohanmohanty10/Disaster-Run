 

local v1 = {}
game:GetService("TweenService")
function v1.start(_, p2, p3, p4) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.Position) then
        while p2.Name ~= "done" do
            p2.BodyPosition.Position = (p3.HumanoidRootPart.CFrame * p4).Position
            game["Run Service"].Heartbeat:Wait()
        end
    end
end
return v1