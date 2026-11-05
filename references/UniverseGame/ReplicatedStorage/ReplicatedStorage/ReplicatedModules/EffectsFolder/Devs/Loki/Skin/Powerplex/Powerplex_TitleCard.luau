  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local ContentProvider = game:GetService("ContentProvider");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local Petal = _G.Petal;
Petal("Util");
Petal("New");
local v1 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = v1.Rng;
local Styles = require(script.Styles);
task.spawn(function() -- Line: 23
    -- upvalues: AssetHandler (copy), ContentProvider (copy)
    ContentProvider:PreloadAsync(AssetHandler.GetAsset("TitleCard", {
        AbilityName = "Killua",
        SkinName = "Powerplex"
    }).Holder:GetChildren());
end);

local function Constrain(p2) -- Line: 28
    return p2 % 360 / 360;
end;

local u3 = {
    Powerplex = 1.5,
    Conquest = 1.75,
    InvincibleWar = 1.5,
    Invincible = 1.45
};
local u4 = {
    Powerplex = { Color3.fromRGB(55, 121, 168), Color3.fromRGB(254, 220, 91) },
    Conquest = { Color3.fromRGB(45, 51, 52), Color3.fromRGB(254, 228, 90) },
    InvincibleWar = { Color3.fromRGB(251, 240, 234), Color3.fromRGB(69, 114, 149) },
    Invincible = { Color3.fromRGB(69, 125, 191), Color3.fromRGB(0, 0, 0) }
};

return function(p5, p6, p7, p8) -- Line: 61
    -- upvalues: Fusion (copy), u4 (copy), AssetHandler (copy), Styles (copy), u3 (copy)
    local u9 = Fusion.Value(Color3.fromRGB(57, 121, 170));
    local u10 = Fusion.Value(Color3.fromRGB(252, 218, 92));

    if p6 and u4[p6] then
        u9:set(u4[p6][1]);
        u10:set(u4[p6][2]);
    end;

    local function CreateAberration(p11, u12, p13) -- Line: 71
        -- upvalues: Fusion (ref), u10 (copy)
        local u14 = {
            Strength = Fusion.Value(p13)
        };

        for i = 1, u12 do
            local v15 = Instance.fromExisting(p11);
            Fusion.Hydrate(v15)({
                ZIndex = 2,
                Name = "Aberration",
                ImageTransparency = 0.5,
                AnchorPoint = Vector2.zero,
                Size = UDim2.fromScale(1, 1),
                Position = Fusion.Spring(Fusion.Computed(function() -- Line: 86
                    -- upvalues: u14 (copy), u12 (copy), i (copy)
                    local v16 = u14.Strength:get();
                    local v17 = v16 / 872;
                    local v18 = v16 / 622.8571428571429;

                    if u12 > 2 then
                        local _ = v16 * (u12 - 2);
                    end;

                    local v19 = UDim2.fromScale(0, 0);

                    if i % 2 == 0 then
                        v17 = -v17 or v17;
                    end;

                    if i % 2 == 0 then
                        v18 = -v18 or v18;
                    end;

                    return v19 + UDim2.fromScale(v17, v18);
                end), 10, 0.7),
                ImageColor3 = Fusion.Computed(function() -- Line: 103
                    -- upvalues: u10 (ref), u12 (copy), i (copy)
                    local v20, _, _ = u10:get():ToHSV();

                    return Color3.fromHSV((v20 * 360 + 90 / math.min(1, u12 - 1) * (i % 2 == 0 and -1 or 1)) % 360 / 360, 0.9019607843137255, 0.8823529411764706);
                end),
                Parent = p11
            });
        end;

        return u14;
    end;

    local u21 = AssetHandler.CloneAsset("TitleCard", {
        AbilityName = "Killua",
        SkinName = "Powerplex"
    });
    local Holder = u21.Holder;
    local u22 = Fusion.Spring(Fusion.Value(Holder.NameLabel.Position), 50, 0.25);
    local v23 = Fusion.Value(Holder.NameLabel.Size);
    local u24 = Random.new();
    local u25 = Styles[p6];
    Fusion.Hydrate(Holder)({
        BackgroundColor3 = u9
    });
    Fusion.Hydrate(Holder.BG)({
        ImageColor3 = u9
    });
    Fusion.Hydrate(Holder.NameLabel)({
        ImageColor3 = u10,
        Position = u22,
        Size = Fusion.Tween(v23, TweenInfo.new(u25 and 5.5 or 3))
    });
    v23:set(UDim2.fromScale(v23:get().X.Scale * 1.1, v23:get().Y.Scale * 1.1));
    local u26 = p5:FindFirstChild("Head") or p5:FindFirstChild("HumanoidRootPart");

    if u26:FindFirstChild("Quote Gui") then
        u26:FindFirstChild("Quote Gui").Enabled = false;
    end;

    u21.Adornee = u26;
    u21.Parent = u26;
    u21.Enabled = true;

    if not u25 then
        task.delay(p7 / p8, function() -- Line: 205
            -- upvalues: u21 (copy), u26 (copy)
            u21:Destroy();

            if u26:FindFirstChild("Quote Gui") then
                u26:FindFirstChild("Quote Gui").Enabled = true;
            end;
        end);

        return;
    end;

    if Holder:FindFirstChild("Audio_" .. p6) then
        local v27 = Holder:FindFirstChild("Audio_" .. p6);
        v27.Parent = u26;
        v27:Play();
    end;

    if p6 == "Conquest" then
        Holder.NameLabel.ImageTransparency = 0;
    end;

    task.wait(u3[p6] or 1.5);
    local u28 = CreateAberration(Holder.NameLabel, 2, 0);
    u28.Strength:set(10);
    local u29 = 0;
    local u30 = 1;
    local u31 = nil;
    u31 = game:GetService("RunService").Heartbeat:Connect(function(p32) -- Line: 171
        -- upvalues: u29 (ref), u30 (ref), u25 (copy), u9 (copy), u10 (copy), u22 (copy), u24 (copy), u28 (copy), u31 (ref), u21 (copy), u26 (copy)
        u29 = u29 + p32;

        while u29 >= 0.055 and u30 <= #u25 do
            local v33 = u25[u30];
            u9:set(v33[1]);
            u10:set(v33[2]);
            u22:addVelocity(UDim2.fromScale(u24:NextNumber(-0.02319, 0.02319), u24:NextNumber(-0.032411, 0.032411)));

            if u30 == 11 then
                u28.Strength:set(13);
            elseif u30 < 11 then
                u28.Strength:set(u24:NextNumber(5, 11));
            end;

            u29 = u29 - 0.055;
            u30 = u30 + 1;
        end;

        if u30 > #u25 then
            u28.Strength:set(0);
            u31:Disconnect();
            task.delay(2.75, function() -- Line: 196
                -- upvalues: u21 (ref), u26 (ref)
                u21:Destroy();

                if u26:FindFirstChild("Quote Gui") then
                    u26:FindFirstChild("Quote Gui").Enabled = true;
                end;
            end);
        end;
    end);
end;