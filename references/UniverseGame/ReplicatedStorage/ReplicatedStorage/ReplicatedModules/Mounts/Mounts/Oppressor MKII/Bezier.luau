  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BezierTween = require(PathShortcuts.ReplicatedModules.BezierTween);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
require(PathShortcuts.KnitPath.TableUtil);
local HttpService = game:GetService("HttpService");
local Output = PathShortcuts.Remotes.Output;
local v1 = {};
local Waypoints = BezierTween.Waypoints;
local PartTemplate = Knit.ClientAssets.Projectiles.PartTemplate;

function v1.CreateProjectile(u2) -- Line: 16
    -- upvalues: Waypoints (copy), PartTemplate (copy), HttpService (copy), Output (copy), BezierTween (copy)
    local v3 = Waypoints.new(unpack(u2.Waypoints));
    local u4 = u2.Projectile or PartTemplate:Clone();
    u4.Name = HttpService:GenerateGUID(false);
    u4.Parent = workspace.Effects;
    Output:FireAllClients("FX", "Clone Projectile", u4.Name, {
        DisplayProjectile = u2.DisplayProjectile,
        Offset = u2.Offset,
        Props = u2.Props,
        SkinName = u2.SkinName
    });
    local v5 = BezierTween.Create(u4, {
        Waypoints = v3,
        EasingStyle = u2.EasingStyle,
        EasingDirection = u2.EasingDirection,
        Time = u2.Time
    });

    if u2.Callback then
        v5.Changed:Connect(u2.Callback);
    end;

    v5.Ended:Connect(function() -- Line: 48
        -- upvalues: u2 (copy), u4 (copy)
        if u2.Destroy == false then
            return;
        end;

        u4:Destroy();

        if u2.Trove then
            u2.Trove:Destroy();
        end;
    end);
    v5:Play();

    return v5;
end;

function v1.ConstructWaypoints(p6) -- Line: 57
    -- upvalues: BezierTween (copy)
    return BezierTween.Waypoints.new(unpack(p6));
end;

return v1;