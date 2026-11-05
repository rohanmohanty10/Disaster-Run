  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local TweenService = game:GetService("TweenService");
local ClientAssetsPath = PathShortcuts.ClientAssetsPath;
local u1 = {
    Tracks = {},
    Animations = {
        Action = {
            Jump = 17823400674
        },
        Movement = {
            ["Karoo Idle"] = 17823404381,
            ["Karoo Forward"] = 17823385301,
            ["Karoo Fall"] = 17823408176
        }
    }
};

function u1.Init(p2, p3) -- Line: 26
    -- upvalues: LocalPlayer (copy), u1 (ref), ClientAssetsPath (copy), TweenService (copy)
    local u4 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local Humanoid = u4:WaitForChild("Humanoid", 3);
    p2.Tracks = {};

    for _, v in Humanoid:GetPlayingAnimationTracks() do
        local v5 = p3.Animations:FindFirstChild(v.Name, true);

        if v5 and string.match(v5.AnimationId, "%d+$") == string.match(v.Animation.AnimationId, "%d+$") then
            p2.Tracks[v.Name] = v;
        end;
    end;

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("Animation") then
            local Name = descendant.Name;

            if not p2.Tracks[Name] then
                p2.Tracks[Name] = Humanoid:LoadAnimation(descendant);

                if descendant:IsDescendantOf(p3.Animations.Movement) then
                    p2.Tracks[Name]:Play();
                    p2.Tracks[Name]:AdjustWeight(0.0001);
                end;
            end;
        end;
    end;

    p2.Tracks["Karoo Forward"]:GetMarkerReachedSignal("Footstep"):Connect(function(p6) -- Line: 62
        -- upvalues: u1 (ref), ClientAssetsPath (ref), u4 (copy), TweenService (ref)
        if not u1.OnGround() then
            return;
        end;

        local v7 = CFrame.new(0.64 * (p6 == "Left" and -1 or 1), -5.35, -1.4);
        local v8 = ClientAssetsPath.KarooFootprint:Clone();
        v8.CFrame = u4.HumanoidRootPart.CFrame * v7;
        v8.Parent = workspace.Effects;
        v8.Sound:Play();
        task.delay(4, v8.Destroy, v8);
        TweenService:Create(v8, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 3), {
            Transparency = 1
        }):Play();
    end);

    return p2.Tracks;
end;

function u1.Step(p9, p10, p11, p12, p13) -- Line: 85
    local v14 = math.abs(p10) > 0;
    local v15 = p9.OnGround();
    p9.Tracks["Karoo Idle"]:AdjustWeight((v14 or not v15) and 0.0001 or 1);
    p9.Tracks["Karoo Forward"]:AdjustSpeed(math.abs(p10) / 37.5);
    p9.Tracks["Karoo Forward"]:AdjustWeight(v14 and v15 and 1 or 0.0001);
    p9.Tracks["Karoo Fall"]:AdjustWeight(v15 and 0.0001 or 1);
end;

u1 = TableUtil.Reconcile(u1, require(game:GetService("ReplicatedStorage").ReplicatedModules.MountAnimators.AnimatorTemplate));
u1:CreateAnimatorFolder(script);

return u1;