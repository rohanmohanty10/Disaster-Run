  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Lighting");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local MoonCutsceneStreamer = require(ReplicatedStorage.Shared.MoonCutsceneStreamer);
local Moonlite = require(ReplicatedStorage.Shared.Moonlite);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local LocalPlayer = game.Players.LocalPlayer;
local LavinhoBDCutscene = ReplicatedStorage.Assets.Vfx.LavinhoBDCutscene;

return function(p1, p2, p3, p4, p5, p6) -- Line: 15
    -- upvalues: MoonCutsceneStreamer (copy), LavinhoBDCutscene (copy), SpectatorController (copy), SoundManager (copy), Players (copy), Moonlite (copy), RunService (copy), LocalPlayer (copy)
    local CutsceneData, v7 = MoonCutsceneStreamer.getCutsceneData(p2);

    if not (CutsceneData and v7) then
        warn("how did this happen. no cutscene data");

        return;
    end;

    local v8 = workspace:FindFirstChild("VFX") or LavinhoBDCutscene.VFX:Clone();

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if p6 then
        SoundManager.SpawnSound("LavinhoBD" .. p6, 0.6, workspace, 150);
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p1);
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Humanoid = p1:FindFirstChild("Humanoid");

    if not Humanoid then
        return;
    end;

    local v9 = v8:FindFirstChild("Lavinho Butterfly Dance VFX");

    if v9 then
        local butterflydanceemitwelded = v9:FindFirstChild("butterflydanceemitwelded");

        if butterflydanceemitwelded then
            butterflydanceemitwelded.WeldConstraint.Part1 = p1.Torso;
        end;

        local butterflydancewings = v9:FindFirstChild("butterflydancewings");

        if butterflydancewings then
            butterflydancewings.WeldConstraint.Part1 = p1.Torso;
        end;
    end;

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
    local Pivot = v8:GetPivot();
    local Pivot2 = HumanoidRootPart:GetPivot();
    v8:PivotTo(Pivot2);
    local Camera = Instance.new("Camera");
    Camera.Name = "CurrentCamera";
    Camera.Parent = v8;
    local v10 = {};
    local u11 = Moonlite.CreatePlayer(CutsceneData, v8);

    if v8:FindFirstChild("lorenzo") then
        for _, child in v8.lorenzo:GetChildren() do
            local v12 = p1:FindFirstChild(child.Name);

            if v12 then
                for _, child2 in child:GetChildren() do
                    child2.Parent = v12;
                    table.insert(v10, child2);
                end;
            end;
        end;

        v8.lorenzo:Destroy();
    end;

    if u11._moduleInfo and p1 then
        for i, v in u11._moduleInfo.Compiled do
            local v13 = v.Path or i;

            if v13.InstanceNames[2] == "lorenzo" then
                local table_clone_ret = table.clone(v13);
                table.remove(table_clone_ret.InstanceNames, 2);
                table.remove(table_clone_ret.InstanceTypes, 2);
                v.Override = Moonlite.resolveAnimPath(table_clone_ret, p1);
            end;

            local CFrame = v.Props.CFrame;

            if CFrame and v13.ItemType ~= "Attachment" then
                CFrame.Default = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(CFrame.Default));

                for _, v2 in CFrame.Sequence do
                    v2.Value = Pivot2:ToWorldSpace(Pivot:ToObjectSpace(v2.Value));
                end;
            end;
        end;
    end;

    for _, child in v8:GetChildren() do
        local v14;

        if child:IsA("LayerCollector") then
            v14 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageLabel") then
                    task.spawn(function() -- Line: 112
                        -- upvalues: child2 (copy), RunService (ref)
                        local v15 = { child2 };
                        game:GetService("ContentProvider"):PreloadAsync(v15);
                        child2.ImageTransparency = 0.999;
                        local v16 = RunService.PreRender:Connect(function() -- Line: 118
                            -- upvalues: child2 (ref)
                            child2.Visible = true;
                        end);

                        while not child2.IsLoaded and child2:IsDescendantOf(game) do
                            task.wait();
                        end;

                        v16:Disconnect();
                        child2.Visible = false;
                        child2.ImageTransparency = 0;
                    end);
                end;
            end;

            v14.Parent = LocalPlayer.PlayerGui;
        elseif child:IsA("PostEffect") then
            child.Parent = workspace.CurrentCamera;
            v14 = child;
        else
            v14 = child;
        end;

        table.insert(v10, v14);
    end;

    u11:Compile();
    v8.Parent = workspace;
    Camera.Changed:Connect(function(p17: string) -- Line: 145
        -- upvalues: Camera (copy)
        if p17 ~= "CFrame" and p17 ~= "FieldOfView" then
            return;
        end;

        workspace.CurrentCamera[p17] = Camera[p17];
    end);
    u11:Play();
    local u18 = false;
    local u19 = nil;
    local PlayerFromCharacter2 = Players:GetPlayerFromCharacter(p1);

    if PlayerFromCharacter2 then
        u19 = Players.PlayerRemoving:Connect(function(p20) -- Line: 159
            -- upvalues: PlayerFromCharacter2 (copy), u19 (ref), u11 (copy), u18 (ref)
            if p20 == PlayerFromCharacter2 then
                u19:Disconnect();
                u11:Stop();
                u11:Destroy();
                u18 = true;
            end;
        end);
    end;

    p3(u11);
    local os_clock_ret = os.clock();
    print("Cutscene: ", p4);

    if p4 == "1" then
        task.wait(3);

        repeat
            task.wait();
        until PlayerFromCharacter:FindFirstChild("BDChoice") or os.clock() - os_clock_ret > u11:GetTimeLength();
    elseif p4 == "3" then
        task.wait(3);

        repeat
            task.wait();
        until PlayerFromCharacter:FindFirstChild("LastChoice") or os.clock() - os_clock_ret > u11:GetTimeLength();

        print("cutscene 3 ended!!!---");
    elseif p5 then
        task.wait(p5);
    else
        u11.Completed:Wait();
    end;

    print("Track completed");
    u11:Stop();
    u11:Destroy();
    Camera:Destroy();

    if u19 then
        u19:Disconnect();
    end;

    if p4 == "5" or u18 then
        v8:Destroy();

        for _, v in v10 do
            v:Destroy();
        end;

        Camera:Destroy();
        LocalPlayer.Character.HumanoidRootPart.Massless = true;
        HumanoidRootPart.Massless = true;
        task.wait();
        LocalPlayer.Character.HumanoidRootPart.Massless = false;
        HumanoidRootPart.Massless = false;
    end;
end;