 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local StarterGui = game:GetService("StarterGui");
require(ReplicatedStorage.allTypes.rig);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local util = ReplicatedStorage.util;
local soundUtil = require(util.soundUtil);
local vfxUtil = require(util.vfxUtil);
local Resources = vfxUtil.getResources();
local Tutorial = ReplicatedStorage.Tutorial;
local PlayerGui = Players.LocalPlayer.PlayerGui;
local v4 = {
    tutorialText = function(u1: string) -- Line: 40, Name: tutorialText
        -- upvalues: PlayerGui (copy), TweenService (copy), Tutorial (copy), soundUtil (copy), ReplicatedStorage (copy), StarterGui (copy)
        local TutorialGui = PlayerGui:FindFirstChild("TutorialGui");

        if not TutorialGui then
            TutorialGui = Instance.new("ScreenGui");
            TutorialGui.Name = "TutorialGui";
            TutorialGui.ResetOnSpawn = false;
            TutorialGui.Parent = PlayerGui;
        end;

        local Dialogue = TutorialGui:FindFirstChild("Dialogue");

        if Dialogue then
            Dialogue.Name = "PreviousDialogue";
            local v2 = TweenService:Create(Dialogue.Frame.Label, TweenInfo.new(0.5), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            });
            v2:Play();
            v2.Completed:Once(function() -- Line: 54
                -- upvalues: Dialogue (copy)
                Dialogue:Destroy();
            end);
        end;

        local v3 = Tutorial.Dialogue:Clone();
        local Label = v3.Frame.Label;
        Label.TextTransparency = 1;
        Label.TextStrokeTransparency = 1;
        Label.Text = "";
        task.defer(function() -- Line: 63
            -- upvalues: u1 (copy), Label (copy), soundUtil (ref), ReplicatedStorage (ref)
            for i = 1, #u1 do
                task.wait(0.03333333333333333);
                Label.Text = u1:sub(1, i);
                soundUtil:play(ReplicatedStorage.Resources.Talk, soundUtil);
                local _ = i;
            end;
        end);
        Label.Position = UDim2.fromScale(0, 3);
        v3.Parent = TutorialGui;
        TweenService:Create(Label, TweenInfo.new(2, Enum.EasingStyle.Quart), {
            TextTransparency = 0,
            TextStrokeTransparency = 0,
            Position = UDim2.fromScale(0, 0)
        }):Play();
        StarterGui:SetCore("ResetButtonCallback", false);
    end
};
local bash = Resources.bash;
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quart);

function v4.shoulder_bash_hit(p5, p6) -- Line: 84
    -- upvalues: vfxUtil (copy), bash (copy), mainreplication (copy), TweenInfo_new_ret (copy)
    local v7 = vfxUtil.isLocalPlayer(p5, p6);
    local Root = vfxUtil.getRoot(p5);
    vfxUtil.quickVFX(bash.hit, "default", Root.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));

    if v7 then
        mainreplication.fov(true, 45, 0.333, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        task.delay(0.333, function() -- Line: 92
            -- upvalues: mainreplication (ref)
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        end);
    end;

    mainreplication.bodyVelocity(Root, 40, 0.5, false, nil, false, TweenInfo_new_ret);
end;

function v4.shoulder_bash_push(p8, p9) -- Line: 103
    -- upvalues: vfxUtil (copy), bash (copy), mainreplication (copy), TweenInfo_new_ret (copy)
    local Root = vfxUtil.getRoot(p8);
    local Root2 = vfxUtil.getRoot(p9);
    vfxUtil.quickVFX(bash.push, "default", Root.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    mainreplication.bodyVelocity(Root, -50, 0.5, false, "RightVector", false, TweenInfo_new_ret);
    mainreplication.bodyVelocity(Root2, 50, 0.5, false, "RightVector", false, TweenInfo_new_ret);
end;

return v4;