 

local v1 = {}
require(game.ReplicatedStorage.Modules.sBeat)
function v1.start(_) --[[ Line: 4 ]]
    local u2 = workspace.NPCs["Gatekeeper Puff"]
    local u3 = { 6.17, 7.12, 8.05 }
    if _G.checkRenderDistance(u2.PrimaryPart.Position) then
        for u4 = 1, #u3 do
            task.spawn(function() --[[ Line: 11 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u4
                    [3] = u2
                --]]
                task.wait(u3[u4])
                local v5 = u2.LeftHand.CFrame
                local v6 = script.Part:Clone()
                v6.Parent = workspace.Effects
                v6.CFrame = v5
                _G.tween(v6.Mesh, {
                    0.2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(50, 50, 50)
                })
                _G.tween(v6, {
                    0.2,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                v6.Attachment.new3.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5, 0), NumberSequenceKeypoint.new(1, 50, 25) })
                v6.Attachment.Lines.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 25, 10), NumberSequenceKeypoint.new(1, 0, 0) })
                v6.Attachment.new2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 50, 10), NumberSequenceKeypoint.new(0.35, 9, 0), NumberSequenceKeypoint.new(1, 0, 0) })
                v6.Attachment.new2:Emit(25)
                v6.Attachment.new3:Emit(25)
                v6.Attachment.Lines:Emit(35)
                _G.destroy(v6, 2.2)
            end)
        end
    end
end
return v1