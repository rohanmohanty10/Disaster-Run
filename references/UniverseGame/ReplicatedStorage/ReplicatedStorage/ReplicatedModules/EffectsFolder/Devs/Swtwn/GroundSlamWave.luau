  

 

return function(p1, p2, p3, p4, p5, p6, p7, p8, u9) -- Line: 1
    local u10 = ({
        Groundeff = game.ReplicatedStorage["Client Assets"].swtwn.Ground.ground1,
        Groundeff2 = game.ReplicatedStorage["Client Assets"].swtwn.Ground.ground2,
        Groundeff3 = game.ReplicatedStorage["Client Assets"].swtwn.Ground.ground3,
        Slameff = game.ReplicatedStorage["Client Assets"].swtwn.Ground.slameff,
        Slameff2 = game.ReplicatedStorage["Client Assets"].swtwn.Ground.slameff2,
        Slameff3 = game.ReplicatedStorage["Client Assets"].swtwn.Ground.slameff3
    })[p2]:Clone();
    u10.Parent = workspace.Effects;
    local v11 = nil;

    if typeof(p4) == "Vector3" then
        if typeof(p4) ~= "Vector3" then
            p4 = v11;
        end;
    else
        p4 = p4.Position;
    end;

    u10.CFrame = CFrame.new(p4);

    if p7 and p7 ~= nil then
        u10.Rotation = p7;
    end;

    if p6 and p6 ~= nil then
        u10.Color = p6;
    end;

    u10.Transparency = 0;
    u10.Size = Vector3.new(0.05, 0.5, 0.05);
    local TweenService = game:GetService("TweenService");
    local v12;

    if p8 then
        v12 = TweenService:Create(u10, TweenInfo.new(p3), {
            Transparency = 1,
            CFrame = u10.CFrame * p8,
            Size = p5
        });
    else
        v12 = TweenService:Create(u10, TweenInfo.new(p3), {
            Transparency = 1,
            Size = p5
        });
    end;

    v12:Play();
    v12.Completed:connect(function() -- Line: 41
        -- upvalues: u9 (copy), u10 (copy)
        if u9 then
            u10.Transparency = 0;

            return;
        end;

        u10:Destroy();
    end);
end;