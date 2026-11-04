 
 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");

({}).Trash = function(u2, p3) -- Line: 5, Name: Trash
    task.delay(p3 or 1, function() -- Line: 6
        -- upvalues: u2 (copy)
        pcall(game.Destroy, u2);
    end);
end;

local MeshFlipbook = require(ReplicatedStorage.util.MeshFlipbook);
local MeshEmitModule = require(ReplicatedStorage.util.MeshEmitModule);

local function emit(p4) -- Line: 14
    for _, v in p4:QueryDescendants("ParticleEmitter") do
        v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
    end;
end;

local function enable(p5, p6) -- Line: 19
    for _, v in p5:QueryDescendants("ParticleEmitter, Beam, Trail") do
        v.Enabled = true;
        task.delay(p6, function() -- Line: 22
            -- upvalues: v (copy)
            v.Enabled = false;
        end);
    end;
end;

function v1.Shove(p7: table) -- Line: 27
    -- upvalues: emit (copy), MeshEmitModule (copy), MeshFlipbook (copy)
    local HumanoidRootPart = p7.Character:FindFirstChild("HumanoidRootPart");
    local u8 = script.StartUp.Miss:Clone();
    u8.Parent = HumanoidRootPart;
    u8:PivotTo(HumanoidRootPart.CFrame);
    emit(u8);
    task.delay(1, function() -- Line: 6
        -- upvalues: u8 (copy)
        pcall(game.Destroy, u8);
    end);
    local v9 = {};
    local u10 = script.StartUp.DecalThing:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    v9.aaa = u10;
    task.delay(8, function() -- Line: 6
        -- upvalues: u10 (copy)
        pcall(game.Destroy, u10);
    end);
    local v11 = script.StartUp.MeshFlipEmit:Clone();
    v11:PivotTo(HumanoidRootPart.CFrame);

    for _, v in v9 do
        MeshEmitModule(v.Start);
    end;

    MeshFlipbook.Create({
        FPS = 140,
        Duration = 2,
        AutoDestroy = true,
        Mesh = script.Meshflipbooks.Meshes.Mesh1,
        TextureFolder = script.Meshflipbooks.Textures:FindFirstChild("MeshSlash"),
        CFrame = v11.MeshFlipEmit.CFrame,
        Parent = workspace.Effects,
        Color = Color3.new(1, 1, 1),
        Transparency = {
            Start = 0.6,
            End = 0.6,
            Tween = {
                Time = 0.8
            }
        },
        Scale = {
            Start = Vector3.new(1, 1, 1),
            End = Vector3.new(20, 20, 20),
            Tween = {
                Time = 0.7,
                EasingStyle = Enum.EasingStyle.Quad,
                EasingDirection = Enum.EasingDirection.Out
            }
        },
        Rotation = {
            Start = Vector3.new(0, 0, 0),
            End = Vector3.new(0, -380, 0),
            Tween = {
                Time = 0.37
            }
        },
        WeldTo = v11.MeshFlipEmit
    });
end;

return v1;