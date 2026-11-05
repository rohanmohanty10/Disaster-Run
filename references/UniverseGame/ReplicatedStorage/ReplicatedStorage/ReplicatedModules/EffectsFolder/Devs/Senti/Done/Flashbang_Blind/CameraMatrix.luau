  

 

local RunService = game:GetService("RunService");
local CurrentCamera = workspace.CurrentCamera;
require(script:WaitForChild("Timer"));
local u1 = {};
local u2 = {
    matrix = {},
    Skew = {},
    Finish = {},
    X = 1,
    Y = 1,
    Elapse = 0
};

function u1.Woozy(p3, p4, p5) -- Line: 22
    -- upvalues: u2 (copy), CurrentCamera (copy)
    local v6 = os.clock();
    local X = u2.X;
    local Y = u2.Y;

    if u2.Finish[p5] then
        if u2.X <= 0.999 and u2.Y <= 0.999 then
            local v7 = (1 - X) * math.sin(v6 * 3.141592653589793) / 10 + X;
            u2.X = math.clamp(v7, X, 1);
            local v8 = (1 - Y) * math.sin(v6 * 3.141592653589793) / 10 + Y;
            u2.Y = math.clamp(v8, Y, 1);
        else
            u2.X = 1;
            u2.Y = 1;
        end;
    else
        local v9 = (0.8 - X) * math.cos(v6 / 0.75 * 3.141592653589793) / 100 + X;
        u2.X = math.clamp(v9, 0, 1);
        local v10 = (0.8 - Y) * math.sin(v6 / 0.75 * 3.141592653589793) / 100 + Y;
        u2.Y = math.clamp(v10, 0, 1);
    end;

    for i = 1, 9 do
        for i2, v in pairs({
            [0] = { 2, 3, 4, 6, 7, 8 },
            [1] = { 9 },
            [u2.X] = { 1 },
            [u2.Y] = { 5 }
        }) do
            for i3 = 1, #v do
                if v[i3] == i then
                    u2.matrix[i] = i2;
                    break;
                end;
            end;
        end;
    end;

    if #u2.matrix >= 9 then
        CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, 0, unpack(u2.matrix));
    end;
end;

function u1.Sporadic(p11, p12) -- Line: 59
    -- upvalues: u2 (copy), CurrentCamera (copy)
    local v13 = Random.new();
    u2.X = v13:NextNumber(p11, 1);
    u2.Y = v13:NextNumber(p11, 1);

    for i = 1, 9 do
        for i2, v in pairs({
            [0] = { 2, 3, 4, 6, 7, 8 },
            [1] = { 9 },
            [u2.X] = { 1 },
            [u2.Y] = { 5 }
        }) do
            for i3 = 1, #v do
                if v[i3] == i then
                    u2.matrix[i] = i2;
                    break;
                end;
            end;
        end;
    end;

    if #u2.matrix >= 9 then
        CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, 0, unpack(u2.matrix));
    end;
end;

function u2.SetupSkew(p14) -- Line: 88
    for i, v in pairs(game.Players:GetPlayers()) do
        if p14.Skew[i] ~= v or p14.Finish[i] ~= v then
            p14.Skew[v] = "nil";
            p14.Finish[v] = false;
        end;
    end;

    for i, child in pairs(workspace.Living:GetChildren()) do
        if p14.Skew[i] ~= child or p14.Finish[i] ~= child then
            p14.Skew[child] = "nil";
            p14.Finish[child] = false;
        end;
    end;
end;

function u2.ManipulateMatrix(u15, u16) -- Line: 102
    -- upvalues: RunService (copy), u1 (copy)
    u15:SetupSkew();

    if u15.Skew[u16.Victim] == "nil" or u15.Finish[u16.Victim] ~= false then
        for i, _ in pairs(u1) do
            if i == u16.Type then
                local Intensity = u16.Intensity;
                u15.Skew[u16.Victim] = RunService:BindToRenderStep("DistortCamera" .. u16.Victim.Name, 201, function(p17) -- Line: 116
                    -- upvalues: u1 (ref), u16 (copy), Intensity (copy), RunService (ref)
                    u1[u16.Type](u16.Intensity, u16.Duration, u16.Victim, p17);

                    if u16.Type ~= "Woozy" then
                        local v18 = u16;
                        v18.Intensity = v18.Intensity + Intensity / (u16.Duration * (1 / p17));

                        if u16.Intensity >= 0.999 then
                            u16.Intensity = 1;
                            RunService:UnbindFromRenderStep("DistortCamera" .. u16.Victim.Name);
                        end;
                    end;
                end);

                if u16.Duration then
                    task.delay(u16.Duration, function() -- Line: 133
                        -- upvalues: u15 (copy), u16 (copy)
                        u15:ManipulateMatrix(u16);
                    end);
                end;
            end;
        end;

        return;
    end;

    u15.Finish[u16.Victim] = true;
    task.delay(1.5, function() -- Line: 108
        -- upvalues: RunService (ref), u16 (copy)
        RunService:UnbindFromRenderStep("DistortCamera" .. u16.Victim.Name);

        return true;
    end);
end;

return u2;