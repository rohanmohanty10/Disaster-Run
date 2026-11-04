  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local MarketplaceService = game:GetService("MarketplaceService");
game:GetService("AvatarEditorService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Tweens);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(script.Parent.Shop);
require(ReplicatedStorage.Shared.FormatNumber);
local RngUtil = require(ReplicatedStorage.Shared.RngUtil);
local WheelData = require(ReplicatedStorage.Shared.Configs.WheelData);
local BattlepassEventData = require(ReplicatedStorage2.Shared.Configs.BattlepassEventData);
require(ReplicatedStorage2.Modules.ReplicatorClient).get("PlayerData");
local LocalPlayer = game.Players.LocalPlayer;
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
v1:WaitForChild("Humanoid");
v1:WaitForChild("HumanoidRootPart");
local Random_new_ret = Random.new();
local u2 = Knit.CreateController({
    Name = "EventSpin"
});
local u3 = false;

local function Lerp(p4, p5, p6) -- Line: 43
    return p4 + (p5 - p4) * p6;
end;

function u2.Spin(u7, p8, p9) -- Line: 48
    -- upvalues: u3 (ref), TweenService (copy), WheelData (copy), Random_new_ret (copy), ReplicatedStorage (copy)
    u3 = true;

    local function ease(p10) -- Line: 53
        -- upvalues: TweenService (ref)
        return TweenService:GetValue(p10, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end;

    local u11 = nil;

    local function move(p12: number) -- Line: 61
        -- upvalues: u11 (ref), TweenService (ref), u7 (copy)
        if u11 then
            TweenService:Create(u7.tiles[u11].UIScale, TweenInfo.new(0.1), {
                Scale = 1
            }):Play();
            u7.tiles[u11].Selected.Visible = false;
        end;

        if p12 then
            TweenService:Create(u7.tiles[p12].UIScale, TweenInfo.new(0.1), {
                Scale = 1.1
            }):Play();
            u7.tiles[p12].Selected.Visible = true;
            u11 = p12;
        end;
    end;

    for i = 1, 14 do
        local v13 = i;
        local v14 = {};

        for i2 = 1, #WheelData do
            local v15;

            if i2 == u11 or i2 == p8 and v13 == 13 then
                v15 = i2;
            else
                table.insert(v14, i2);
                v15 = i2;
            end;
        end;

        move(v14[Random_new_ret:NextInteger(1, #v14)]);
        ReplicatedStorage.Assets.Sfx.WheelTick:Play();
        task.wait(v13 / 14 * 0.4 + 0.12);
    end;

    move(p8);
    ReplicatedStorage.Assets.Sfx.WheelTick:Play();
    task.wait(1.5);

    if u11 then
        TweenService:Create(u7.tiles[u11].UIScale, TweenInfo.new(0.1), {
            Scale = 1
        }):Play();
        u7.tiles[u11].Selected.Visible = false;
    end;

    u3 = false;
end;

function u2.KnitStart(p16) -- Line: 103
    -- upvalues: Knit (copy), LocalPlayer (copy), RngUtil (copy), WheelData (copy), MarketplaceService (copy), u3 (ref), u2 (copy), BattlepassEventData (copy)
    local Service = Knit.GetService("SpinwheelService");
    Knit.GetController("DiscountController");
    p16.Instance = LocalPlayer.PlayerGui:WaitForChild("BattlepassEvent").Frame.Sections.Crates;
    p16.tiles = {};

    for _, child in p16.Instance.Items:GetChildren() do
        p16.tiles[tonumber(child.Name)] = child;
        child:SetAttribute("Size", child.Size);
    end;

    local v19 = RngUtil.ConvertToWeightMap(WheelData, function(p17, p18) -- Line: 117
        return p17, p18[2];
    end);
    RngUtil.ToChances(v19);

    for _, child in p16.Instance:GetChildren() do
        if child:IsA("ImageButton") and child:GetAttribute("ID") then
            child.Activated:Connect(function() -- Line: 125
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref), child (copy)
                MarketplaceService:PromptProductPurchase(LocalPlayer, child:GetAttribute("ID"));
            end);
        end;
    end;

    p16.Instance.Spin.Activated:Connect(function() -- Line: 139
        -- upvalues: u3 (ref), Service (copy)
        if u3 then
            return;
        end;

        Service:Spin();
    end);
    Service.SpinResults:Connect(function(p20) -- Line: 149
        -- upvalues: u2 (ref)
        u2:Spin(p20.prize, 6);
    end);
    p16.Instance.Spin.Label.Text = "Spin " .. BattlepassEventData.CRATE_COST;

    return p16;
end;

return u2;