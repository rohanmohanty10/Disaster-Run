  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local u1 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
local u2 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p3, p4) -- Line: 8
    -- upvalues: TweenService (copy), u2 (copy), Debris (copy), AssetHandler (copy), u1 (copy)
    local ATrainPoseBrick = p3:FindFirstChild("ATrainPoseBrick");

    if ATrainPoseBrick then
        ATrainPoseBrick.Name = "Disappearing";
        ATrainPoseBrick:SetAttribute("Stop", true);

        for _, child in ATrainPoseBrick:GetChildren() do
            if child:IsA("Attachment") then
                TweenService:Create(child.Pink, u2, {
                    Range = 0
                }):Play();
            end;
        end;

        Debris:AddItem(ATrainPoseBrick, u2.Time + 0.5);
    end;

    if not p4 then
        return;
    end;

    local v5 = AssetHandler.CloneAsset("Models/StarryLights", {
        AbilityName = "UGrain Dev"
    });

    for _, child in v5:GetChildren() do
        if child:IsA("Attachment") then
            local u6 = TweenService:Create(child.Pink, u1, {
                Range = child.Pink.Range
            });
            child.Pink.Range = 0;
            u6:Play();
            u6.Completed:Once(function() -- Line: 34
                -- upvalues: u6 (copy)
                u6:Destroy();
            end);
        end;
    end;

    v5.Name = "ATrainPoseBrick";
    v5.Parent = p3;
    v5.CFrame = p3.Torso.CFrame;
    v5.Anchored = false;
    v5.Weld.Part0 = p3.Torso;

    repeat
        local v7 = task.wait();
        local Weld = v5.Weld;
        Weld.C1 = Weld.C1 * CFrame.Angles(0, math.rad(4 * v7 * 60), 0);
    until not p3:IsDescendantOf(game) or (not v5 or v5 and v5:GetAttribute("Stop"));
end;