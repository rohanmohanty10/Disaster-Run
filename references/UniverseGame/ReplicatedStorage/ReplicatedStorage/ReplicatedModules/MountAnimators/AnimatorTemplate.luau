  

 

local v1 = {
    Tracks = {},
    Animations = {}
};
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };
local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;

function v1.CreateAnimatorFolder(p3, p4) -- Line: 14
    local v5 = p4 or script;

    if not v5:FindFirstChild("Animations") then
        local Folder = Instance.new("Folder");
        Folder.Name = "Animations";
        Folder.Parent = v5;

        for i, v in p3.Animations do
            local Folder2 = Instance.new("Folder");
            Folder2.Name = i;
            Folder2.Parent = Folder;

            for i2, v2 in v do
                if v2 then
                    local Animation = Instance.new("Animation");
                    Animation.AnimationId = "rbxassetid://" .. v2;
                    Animation.Name = i2;
                    Animation.Parent = Folder2;
                end;
            end;
        end;
    end;
end;

function v1.Init(p6) -- Line: 41
end;

function v1.Step(p7) -- Line: 45
end;

function v1.GetAnimation(p8, p9) -- Line: 49
    return p8.Tracks[p9];
end;

function v1.PlayAnimation(p10, p11, p12) -- Line: 53
    local v13 = p10:GetAnimation(p11);

    if v13 then
        v13:Play();

        if v13 and typeof(p12) == "number" then
            v13:AdjustSpeed(p12);
        end;

        return v13;
    end;
end;

function v1.IsPlaying(p14, p15, p16) -- Line: 65
    local v17 = p14:GetAnimation(p15);

    if v17 then
        return v17.IsPlaying or (p16 or 1) <= v17.WeightTarget;
    end;
end;

function v1.StopAllTracks(p18, ...) -- Line: 72
    for _, v in p18.Tracks do
        v:Stop(...);
    end;
end;

function v1.WeightAllTracks(p19, p20, p21) -- Line: 78
    for _, v in p21 or p19.Tracks do
        local v22 = p19.Tracks[v];

        if v22 then
            v22:AdjustWeight(p20);
        end;
    end;
end;

function v1.OnGround(p23, p24, p25, p26) -- Line: 88
    -- upvalues: LocalPlayer (copy), u2 (copy)
    local v27 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    v27:WaitForChild("Humanoid", 3);
    local HumanoidRootPart = v27:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        local v28 = workspace;
        local v29 = p25 or HumanoidRootPart.Position;
        local v30;

        if p26 then
            v30 = p26 * p24;
        else
            v30 = Vector3.new(0, p24 or -6, 0);
        end;

        return v28:Raycast(v29, v30, u2);
    end;
end;

return v1;