 

local v1 = {}
local u2 = game:GetService("TweenService")
function v1.start(_, u3) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.root.Position) then
        local u4 = TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
        local function u8(p5) --[[ Line: 12 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u2
                [3] = u4
            --]]
            for _, v6 in u3.Model[p5]:GetChildren() do
                local v7 = v6.Mesh
                u2:Create(v7, u4, {
                    ["Scale"] = v7:GetAttribute("InitialScale")
                }):Play()
            end
        end
        spawn(function() --[[ Line: 20 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u8
            --]]
            if u3.Name == "BatNoob" then
                local v9 = u3.Model.Handle.HandleShaft
                v9.Sparkles:Emit(2)
                v9.Waves:Emit(4)
                _G.PlaySound(v9, script.Appear)
                _G.PlaySound(v9, script.Pop)
                u8("Handle")
                task.wait(0.05)
                u3.Model.Pole.Main.AirWave:Emit(2)
                u3.Model.Pole.Main.Sparkles:Emit(1)
                _G.PlaySound(u3.Model.Pole.Main, script.Pop, {
                    ["PlaybackSpeed"] = 0.7
                })
                u8("Pole")
            else
                local v10 = u3.root
                v10.FillStar:Emit(1)
                v10.HollowStar:Emit(4)
                _G.PlaySound(v10, script.FinishDoll)
                _G.PlaySound(v10, script.Pop, {
                    ["PlaybackSpeed"] = 1.25
                })
                u8("All")
            end
        end)
    end
end
return v1