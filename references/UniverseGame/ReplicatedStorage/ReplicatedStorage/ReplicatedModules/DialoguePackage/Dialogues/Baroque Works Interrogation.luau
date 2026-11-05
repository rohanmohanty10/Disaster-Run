  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local _ = PathShortcuts.RemotesPath.UIOutput;
local u2 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u3 = Dialogue.new();
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
u3:SetTitle("Baroque Works Traitor");
u3.CannotClose = true;
u3.YieldResponses = true;
local u4 = nil;
local u5 = nil;
local u6 = nil;

local function SetCameraPerspective(u7) -- Line: 27
    -- upvalues: u4 (ref), u5 (ref), CurrentCamera (copy), u6 (ref), LocalPlayer (copy), TweenService (copy), SetCameraPerspective (copy)
    if u4 then
        u4:Pause();
    end;

    u5 = u7;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;

    if not u7 then
        CurrentCamera.FieldOfView = 70;
        pcall(function() -- Line: 38
            -- upvalues: u6 (ref), LocalPlayer (ref), CurrentCamera (ref), u5 (ref)
            if u6 then
                local v8 = u6:GetChildren()[math.random(1, #u6:GetChildren())];

                while LocalPlayer.Character:IsDescendantOf(game) and LocalPlayer.Character:GetAttribute("Interrogation") do
                    CurrentCamera.CFrame = v8.CFrame;
                    local _ = u6:GetChildren()[math.random(1, #u6:GetChildren())];
                    local v9;

                    repeat
                        v9 = u6:GetChildren()[math.random(1, #u6:GetChildren())];
                        task.wait();
                    until v9 ~= v8;

                    task.wait(6);

                    if u5 ~= nil then
                        break;
                    end;

                    v8 = v9;
                end;
            end;
        end);

        return;
    end;

    CurrentCamera.FieldOfView = 40;
    CurrentCamera.CFrame = u7.Head.CFrame * CFrame.new(-1.5, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0);
    u4 = TweenService:Create(CurrentCamera, TweenInfo.new(7.5, Enum.EasingStyle.Linear), {
        CFrame = CurrentCamera.CFrame * CFrame.new(-3, 0, 0)
    });
    u4:Play();
    u4.Completed:Connect(function() -- Line: 70
        -- upvalues: u5 (ref), u7 (copy), LocalPlayer (ref), SetCameraPerspective (ref)
        if u5 == u7 and LocalPlayer.Character:GetAttribute("Interrogation") then
            task.spawn(SetCameraPerspective);
        end;
    end);
end;

local function ResetCamera() -- Line: 78
    -- upvalues: u4 (ref), u5 (ref), CurrentCamera (copy), LocalPlayer (copy)
    if u4 then
        u4:Cancel();
    end;

    u5 = nil;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;
end;

function u3.Setup(p10, p11) -- Line: 89
    -- upvalues: LocalPlayer (copy), u3 (copy), SetCameraPerspective (copy), ResetCamera (copy), u2 (copy), u6 (ref), u4 (ref), u5 (ref), CurrentCamera (copy)
    local u14 = LocalPlayer.Character.AncestryChanged:Connect(function(p12, p13) -- Line: 90
        -- upvalues: u3 (ref)
        if not p13 then
            u3:Destroy();
        end;
    end);

    if p11 == true then
        local u15 = u3:GetNPCModel();
        u3:SetText("It can\'t be... NO! Come on. Come on. How did you find me????");
        SetCameraPerspective(u15);
        u3:AddResponse("I\'ll let you off with a beating if you tell me everything you know right know.", function() -- Line: 100
            -- upvalues: SetCameraPerspective (ref), LocalPlayer (ref), u3 (ref)
            SetCameraPerspective(LocalPlayer.Character);
            u3:SetText("OH YEAH! Everything I know. Yup. I\'ll tell you everything I know. Sure.");

            return "Continue";
        end):LinkResponse("I am all ears right now.", function() -- Line: 104
            -- upvalues: SetCameraPerspective (ref), u15 (copy), u3 (ref), ResetCamera (ref), u2 (ref)
            SetCameraPerspective(u15);
            u3:SetText("I just know that... ONE OF US WONT BE MAKING IT OUT OF HERE ALIVE! BRING IT ON! PREPARE FOR THE POWERS OF MY ASHURA!");
            task.delay(2, ResetCamera);
            task.delay(4, function() -- Line: 110
                -- upvalues: u3 (ref), u2 (ref), u15 (ref)
                u3:Destroy();
                u2:CheckRequirement("ChaseEnd", u15):expect();
            end);

            return "ClearResponses";
        end);

        return;
    end;

    local u16 = LocalPlayer.Character:GetAttributeChangedSignal("Interrogation"):Connect(function() -- Line: 120
        -- upvalues: LocalPlayer (ref), u3 (ref)
        if not LocalPlayer.Character:GetAttribute("Interrogation") then
            u3:Destroy();
        end;
    end);
    local CinematicBlackBars = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("CinematicBlackBars");
    CinematicBlackBars.Enabled = true;
    CinematicBlackBars.Upper.Position = UDim2.fromScale(0.5, -0.88);
    CinematicBlackBars.Upper.Rotation = 0;
    CinematicBlackBars.Lower.Position = UDim2.fromScale(0.5, 0.88);
    CinematicBlackBars.Lower.Rotation = 0;
    u3:SetText("...");
    table.clear(p10._Responses);
    u3:AddCallback("OnDestroy", function(p17) -- Line: 137
        -- upvalues: u16 (copy), u14 (copy), CinematicBlackBars (copy)
        table.clear(p17._Responses);
        u16:Disconnect();
        u14:Disconnect();
        CinematicBlackBars.Enabled = false;
    end);
    local v18 = workspace.Map:WaitForChild("InterrogationRoom" .. p11, 5);

    if v18 then
        v18 = v18.CameraPoints;
    end;

    u6 = v18;
    task.spawn(SetCameraPerspective);
    local u19 = u3:GetNPCModel();
    u3:AddResponse("I don\'t have all day. Spill it.", function() -- Line: 153
        -- upvalues: SetCameraPerspective (ref), u19 (copy), u3 (ref)
        SetCameraPerspective(u19);
        u3:SetText("SPILL WHAT? FIRST, YOU KIDNAP ME, BEAT ME UP, AND NOW YOU\'RE ASKING ME TO SPILL \"IT\"? WHAT MORE DO YOU WANT FROM ME?");

        return "Continue";
    end):LinkResponse("Don\'t play stupid. We know you trespassed into our treasure room. Spill where the stolen goods are.", function() -- Line: 157
        -- upvalues: SetCameraPerspective (ref), LocalPlayer (ref), u3 (ref)
        SetCameraPerspective(LocalPlayer.Character);
        u3:SetText("I have no idea what you are talking about. Nope. Not a single world is coming out of this mouth.");

        return "Continue";
    end):LinkResponse("Do you need me to count them one by one? Our stand arrows, blueprints... Shall I keep going?", function() -- Line: 161
        -- upvalues: SetCameraPerspective (ref), u19 (copy), u3 (ref)
        SetCameraPerspective(u19);
        u3:SetText("I ALREADY TOLD YOU I DON\'T HAVE A SINGLE CLUE!");

        return "Continue";
    end):LinkResponse("Are you sure you would like things to end this way? You may still be spared, should you tell us where they are.", function() -- Line: 165
        -- upvalues: SetCameraPerspective (ref), LocalPlayer (ref), u3 (ref)
        SetCameraPerspective(LocalPlayer.Character);
        u3:SetText("Really... Do you promise...?");

        return "Continue";
    end):LinkResponse("Yup. Now, where are they?", function() -- Line: 169
        -- upvalues: u4 (ref), u5 (ref), CurrentCamera (ref), LocalPlayer (ref), u2 (ref), u19 (copy), u3 (ref)
        if u4 then
            u4:Cancel();
        end;

        u5 = nil;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;
        u2:CheckRequirement("InterrogationEnd", u19):expect();
        u3:SetText("HAHAHAHA! YOU WON\'T BE GETTING ANYTHING OUT OF ME");

        return "ClearResponses";
    end);
end;

return u3;