  

 

local function Lerp(p1, p2, p3) -- Line: 1
    return p1 + (p2 - p1) * p3;
end;

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u4 = {
    Baseplate = "rbxassetid://7017133967",
    Desert = "rbxassetid://118718014405263",
    ["Basketball Court"] = "rbxassetid://136215985874096",
    Colosseum = "rbxassetid://95118873336451",
    ["East Park"] = "rbxassetid://97748279677689",
    ["East Riverside Park"] = "rbxassetid://137351597901756",
    ["Knight\'s Cavern"] = "rbxassetid://108342356081648",
    Subway = "rbxassetid://80825720557148",
    Village = "rbxassetid://111079671713053",
    ["West Park"] = "rbxassetid://137633308744286",
    ["West Riverside Park"] = "rbxassetid://137326007020272",
    ["West Station"] = "rbxassetid://137904251842151"
};

return function(p5) -- Line: 23
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), u4 (copy)
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local Locations = Parent.Locations;
    local Close = Parent.Close;
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    require(ReplicatedStorage.ReplicatedModules.Types);
    Core.OnStart():await();
    local u6 = Core.GetClientService("FastTravelService");

    if Core.Flags.DisableFastTravel then
        return;
    end;

    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    local Knit = require(PathShortcuts.KnitPath.Knit);
    local Trove = require(Knit.Util.Trove);
    local FastTravelPoints = workspace.Map:WaitForChild("FastTravelPoints");
    local u7 = nil;
    local u8 = nil;
    local u9 = Fusion.Value(false);
    local u10 = Fusion.Value({});
    local u11 = Fusion.Spring(Fusion.Computed(function() -- Line: 49
        -- upvalues: u9 (copy)
        return u9:get() and 0 or 1;
    end), 25, 0.7);

    local function Clean() -- Line: 53
        -- upvalues: u7 (ref)
        if u7 then
            u7:Destroy();
            u7 = nil;
        end;
    end;

    local function GetLocationsExcept(p12) -- Line: 60
        -- upvalues: FastTravelPoints (copy)
        local v13 = FastTravelPoints:GetChildren();

        for i, v in v13 do
            if v.Name == p12 then
                table.remove(v13, i);
            end;
        end;

        return v13;
    end;

    local function PromptFastTravel(p14) -- Line: 72
        -- upvalues: LocalPlayer (ref), FastTravelPoints (copy), u7 (ref), GetLocationsExcept (copy), Trove (copy), u8 (ref), u9 (copy), u10 (copy)
        if not (LocalPlayer.Character and LocalPlayer.Character.Parent) then
            return;
        end;

        if not FastTravelPoints:FindFirstChild(p14) then
            return;
        end;

        if u7 then
            u7:Destroy();
            u7 = nil;
        end;

        local u15 = true;
        local v16 = GetLocationsExcept(p14);
        local u17 = FastTravelPoints:FindFirstChild(p14);
        local v18 = Trove.new();
        u7 = v18;
        u8 = p14;
        u9:set(true);
        u10:set(v16);
        task.spawn(function() -- Line: 97
            -- upvalues: LocalPlayer (ref), u15 (ref), u17 (copy), u7 (ref)
            while LocalPlayer.Character and (LocalPlayer.Character.Parent and (u15 and LocalPlayer:DistanceFromCharacter(u17:GetPivot().Position) < 17)) do
                task.wait(0.06666666666666667);
            end;

            if u7 then
                u7:Destroy();
                u7 = nil;
            end;
        end);
        v18:Add(function() -- Line: 109
            -- upvalues: u8 (ref), u15 (ref), u9 (ref), u10 (ref)
            task.defer(function() -- Line: 110
                -- upvalues: u8 (ref)
                u8 = nil;
            end);
            u15 = false;
            u9:set(false);
            u10:set({});
        end);
    end;

    local function CreateLocationFrame(p19, p20) -- Line: 120
        -- upvalues: Assets (copy), u4 (ref)
        local v21 = Assets.Location:Clone();
        v21.Label.Text = p19 .. ` (<font color="#838383">{math.round(p20)} studs</font>)`;
        v21.Visible = true;
        v21.LayoutOrder = p20;

        if u4[p19] then
            v21.Preview.Image = u4[p19];
        end;

        return v21;
    end;

    local function RequestFastTravel(p22) -- Line: 133
        -- upvalues: u6 (copy), u8 (ref), u7 (ref)
        local v23 = u6:RequestFastTravel(u8, p22):expect();

        if v23 and u7 then
            u7:Destroy();
            u7 = nil;
        end;

        print(v23);
    end;

    Fusion.Hydrate(Close)({
        [Fusion.OnEvent("MouseButton1Click")] = Clean
    });
    Fusion.Hydrate(Parent)({
        GroupTransparency = u11,
        Visible = Fusion.Computed(function() -- Line: 149
            -- upvalues: u11 (copy)
            return u11:get() <= 0.995;
        end),
        Position = Fusion.Spring(Fusion.Computed(function() -- Line: 152
            -- upvalues: u9 (copy)
            return u9:get() and UDim2.fromScale(0.5, 0.544) or UDim2.fromScale(0.5, 0.57);
        end), 25, 0.7)
    });
    Fusion.Hydrate(Locations)({
        [Fusion.Children] = Fusion.ForValues(u10, function(u24) -- Line: 158
            -- upvalues: LocalPlayer (ref), Assets (copy), u4 (ref), Fusion (copy), u6 (copy), u8 (ref), u7 (ref)
            local v25 = LocalPlayer:DistanceFromCharacter(u24:GetPivot().Position);
            local Name = u24.Name;
            local v26 = Assets.Location:Clone();
            v26.Label.Text = Name .. ` (<font color="#838383">{math.round(v25)} studs</font>)`;
            v26.Visible = true;
            v26.LayoutOrder = v25;

            if u4[Name] then
                v26.Preview.Image = u4[Name];
            end;

            local u27 = UDim2.fromScale(1, 1);
            local u28 = Fusion.Value(u27);
            Fusion.Hydrate(v26)({
                [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 166
                    -- upvalues: u24 (copy), u6 (ref), u8 (ref), u7 (ref)
                    local v29 = u6:RequestFastTravel(u8, u24.Name):expect();

                    if v29 and u7 then
                        u7:Destroy();
                        u7 = nil;
                    end;

                    print(v29);
                end,

                [Fusion.OnEvent("MouseEnter")] = function() -- Line: 169
                    -- upvalues: u28 (copy), u27 (copy)
                    u28:set(u27 + UDim2.fromScale(0.2, 0.2));
                end,

                [Fusion.OnEvent("MouseLeave")] = function() -- Line: 172
                    -- upvalues: u28 (copy), u27 (copy)
                    u28:set(u27);
                end
            });
            Fusion.Hydrate(v26.Preview)({
                Size = Fusion.Spring(u28, 15, 0.95)
            });

            return v26;
        end, Fusion.cleanup)
    });
    u6.PromptFastTravel:Connect(PromptFastTravel);
end;