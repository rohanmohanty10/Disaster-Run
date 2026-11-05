  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Core = require(ReplicatedStorage.ReplicatedRoot.Core);
require(ReplicatedStorage.ReplicatedModules.Types);
local DialogueTrees = ReplicatedStorage.ReplicatedModules.DialoguePackage.DialogueTrees;
local Signal = require(Core.ReplicatedLibraries.Classes.Signal);
local Trove = require(Core.ReplicatedLibraries.Classes.Trove);
local TableUtil = require(Core.ReplicatedLibraries.Utility.TableUtil);
local u1 = {
    Prototype = {}
};
u1.Prototype.__index = u1.Prototype;

function u1.ResolveFromPath(p2) -- Line: 55
    -- upvalues: DialogueTrees (copy)
    local v3 = string.split(p2, "/");
    local v4 = #v3;
    local v5 = "Node";

    if v4 > 1 then
        if v3[1] == "~" then
            local v6 = DialogueTrees;

            for i = 2, v4 do
                local v7;

                if typeof(v6) == "Instance" then
                    v7 = v6:FindFirstChild(v3[i]);
                elseif typeof(v6) == "table" then
                    v7 = v6.Nodes and v6.Nodes[v3[i]] or v3[p2[i]];
                else
                    v7 = nil;
                end;

                if v7 then
                    if typeof(v7) == "Instance" and v7:IsA("ModuleScript") then
                        v6 = require(v7) or v7;
                    else
                        v6 = v7;
                    end;
                end;
            end;

            return v6, v6 and v6.Nodes and "Tree" or v5;
        end;
    elseif v4 == 1 then
        return v3[1], v5;
    end;
end;

function u1.new(p8, p9) -- Line: 86
    -- upvalues: Trove (copy), Signal (copy), u1 (copy)
    local v10 = Trove.new();
    local v11 = {
        _Current = nil,
        _Tree = p8,
        Metadata = p9,
        Trove = v10,
        NodeEntered = v10:Construct(Signal),
        Ended = v10:Construct(Signal)
    };

    return setmetatable(v11, u1.Prototype);
end;

function u1.Prototype.SetCurrentNode(p12, p13) -- Line: 105
    -- upvalues: TableUtil (copy)
    if not p13 then
        return;
    end;

    if p12:GetCurrentNode() ~= p13 then
        if p12._Current and p12._Current.Mutable then
            table.clear(p12._Current);
            table.freeze(p12._Current);
        end;

        if not table.isfrozen(p13) then
            table.freeze(p13);
        end;

        if p13.Mutable then
            p13 = TableUtil.Copy(p13, true);
        end;

        p12._Current = p13;
        p12:Enter();
    end;
end;

function u1.Prototype.Enter(p14, p15) -- Line: 129
    local v16 = p15 or p14:GetCurrentNode();

    if not v16 then
        return;
    end;

    if v16.Transformer then
        v16.Transformer(p14, v16);
    end;

    p14.NodeEntered:Fire(v16);
end;

function u1.Prototype.Choose(p17, p18) -- Line: 144
    -- upvalues: u1 (copy)
    if p18.Callback then
        p18.Callback(p17, p18);
    end;

    if p18.Next and p18.Next ~= u1.PLACEHOLDER then
        if typeof(p18.Next) == "table" then
            p17:SetCurrentNode(p18.Next);

            return;
        end;

        if typeof(p18.Next) == "string" then
            local v19, _ = u1.ResolveFromPath(p18.Next);

            if typeof(v19) == "table" then
                p17:SetCurrentNode(v19);

                return;
            end;

            p17:SetCurrentNode((p17:GetNode(p18.Next)));
        end;
    else
        p17:Destroy();
    end;
end;

function u1.Prototype.GetNode(p20, p21) -- Line: 168
    local v22 = p20:GetTree();

    if v22.Nodes and v22.Nodes[p21] then
        return v22.Nodes[p21];
    end;
end;

function u1.Prototype.GetCurrentNode(p23) -- Line: 178
    return p23._Current;
end;

function u1.Prototype.GetTree(p24) -- Line: 182
    return p24._Tree;
end;

function u1.Prototype.GetMetadata(p25) -- Line: 186
    return p25.Metadata;
end;

function u1.Prototype.Init(p26) -- Line: 190
    local v27 = p26:GetTree();
    local Start = v27.Start;

    if typeof(Start) == "function" then
        Start = Start(v27);
    end;

    local v28 = p26:GetNode(Start);

    if v28 then
        p26:SetCurrentNode(v28);

        return;
    end;

    error((`Failed to get start node: {Start}`));
end;

function u1.Prototype.Destroy(p29) -- Line: 209
    if table.isfrozen(p29) then
        return;
    end;

    p29.Ended:Fire();
    p29.Trove:Destroy();

    if p29._Current and p29._Current.Mutable then
        table.clear(p29._Current);
        table.freeze(p29._Current);
    end;

    if p29.Metadata then
        table.clear(p29.Metadata);
        table.freeze(p29.Metadata);
    end;

    table.clear(p29);
    table.freeze(p29);
    print("Destroyed");
end;

u1.PLACEHOLDER = "";

return u1;