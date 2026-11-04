 

local v1 = {}
mOVthreshold = 0.01
globalMinThickness = 0.05
function GenerateParallelogram(p2, p3, p4, p5, p6)
    local v7 = p6 or globalMinThickness
    local v8 = p3 - p2
    local v9 = p4 - p2
    local v10 = v8:Dot(v9) / (v8.magnitude * v9.magnitude)
    local v11 = math.acos(v10)
    local v12, v13
    if v11 > 1.5707963267948966 then
        local v14 = v9.magnitude
        local v15 = v11 - 1.5707963267948966
        v12 = v14 * math.sin(v15)
        local v16 = v9.magnitude
        local v17 = v11 - 1.5707963267948966
        v13 = v16 * math.cos(v17)
    else
        v12 = v9.magnitude * math.cos(v11)
        v13 = v9.magnitude * math.sin(v11)
    end
    if v8.magnitude <= v12 then
        return GenerateParallelogram(p4, p2, p4 + v8, p5, v7)
    end
    local v18 = (p2 + p4) / 2
    local v19 = (p3 + p4) / 2
    local v20 = (p4 + v8 + p3) / 2
    local v21 = v8.Unit
    local v22 = v8:Cross(v9).Unit
    local v23 = v21:Cross(v22)
    local v24 = v11 > 1.5707963267948966 and 1 or -1
    local v25 = Instance.new("WedgePart")
    v25.Parent = p5
    v25.Anchored = true
    local v26
    if v13 < globalMinThickness then
        v26 = globalMinThickness or v13
    else
        v26 = v13
    end
    local v27
    if v12 < globalMinThickness then
        v27 = globalMinThickness or v12
    else
        v27 = v12
    end
    v25.Size = Vector3.new(v7, v26, v27)
    v25.CFrame = CFrame.new(v18.x, v18.y, v18.z, v24 * v22.x, v24 * v23.x, v21.x, v24 * v22.y, v24 * v23.y, v21.y, v24 * v22.z, v24 * v23.z, v21.z)
    v25.BottomSurface = 0
    local v28 = Instance.new("WedgePart")
    v28.Parent = p5
    v28.Anchored = true
    local v29
    if v13 < globalMinThickness then
        v29 = globalMinThickness or v13
    else
        v29 = v13
    end
    local v30
    if v12 < globalMinThickness then
        v30 = globalMinThickness or v12
    else
        v30 = v12
    end
    v28.Size = Vector3.new(v7, v29, v30)
    v28.CFrame = CFrame.new(v20.x, v20.y, v20.z, v24 * v22.x, -v24 * v23.x, -v21.x, v24 * v22.y, -v24 * v23.y, -v21.y, v24 * v22.z, -v24 * v23.z, -v21.z)
    v28.BottomSurface = 0
    local v31 = Instance.new("Part")
    v31.Parent = p5
    v31.Anchored = true
    if v13 < globalMinThickness then
        v13 = globalMinThickness or v13
    end
    local v32 = v8.magnitude - v12 < globalMinThickness and globalMinThickness or v8.magnitude - v12
    v31.Size = Vector3.new(v7, v13, v32)
    v31.CFrame = CFrame.new(v19.x, v19.y, v19.z, v22.x, v23.x, v21.x, v22.y, v23.y, v21.y, v22.z, v23.z, v21.z)
    v31.TopSurface = 0
    v31.BottomSurface = 0
    return v25, v28, v31
end
function GenerateTriangle(p33, p34, p35, p36, p37)
    local v38 = p37 or globalMinThickness
    local v39 = { p35, p33, p34 }
    local v40 = { p35 - p34, p33 - p35, p34 - p33 }
    local v41 = { v40[1].magnitude, v40[2].magnitude, v40[3].magnitude }
    local v42 = unpack
    local v43 = math.max(v42(v41))
    local v44 = v43 == v41[1] and 1 or (v43 == v41[2] and 2 or 3)
    local v45 = v40[v44]
    local v46 = (v44 + 1) % 3 + 1
    local v47 = v44 % 3 + 1
    local v48 = v39[v46] - v40[v46] / 2
    local v49 = v39[v47] - v40[v47] / 2
    local v50 = v40[v46]:Dot(v45) / v43
    local v51 = math.abs(v50)
    local v52 = v40[v47]:Dot(v45) / v43
    local v53 = math.abs(v52)
    local v54 = v41[v46] ^ 2 - v51 ^ 2
    local v55 = math.sqrt(v54)
    local v56 = Instance.new("WedgePart")
    v56.Parent = p36
    v56.Anchored = true
    v56.TopSurface = 0
    v56.BottomSurface = 0
    local v57 = v56:Clone()
    v57.Parent = p36
    local v58
    if v55 < globalMinThickness then
        v58 = globalMinThickness or v55
    else
        v58 = v55
    end
    if v51 < globalMinThickness then
        v51 = globalMinThickness or v51
    end
    local v59 = Vector3.new(v38, v58, v51)
    if v55 < globalMinThickness then
        v55 = globalMinThickness or v55
    end
    if v53 < globalMinThickness then
        v53 = globalMinThickness or v53
    end
    local v60 = Vector3.new(v38, v55, v53)
    v56.Size = v59
    v57.Size = v60
    local v61 = v45:Cross(-v40[v46]).Unit
    local v62 = v45.Unit
    local v63 = v61:Cross(v62)
    v56.CFrame = CFrame.new(v48.x, v48.y, v48.z, -v61.x, v63.x, v62.x, -v61.y, v63.y, v62.y, -v61.z, v63.z, v62.z)
    v57.CFrame = CFrame.new(v49.x, v49.y, v49.z, v61.x, v63.x, -v62.x, v61.y, v63.y, -v62.y, v61.z, v63.z, -v62.z)
    return v56, v57
end
function InvertPartOutwards(p64)
    local v65, v66, v67, v68, v69, v70, v71, v72, v73, v74, v75, v76 = p64.CFrame:components()
    local v77 = Vector3.new(v70, v73, v76):Dot(Vector3.new(v68, v71, v74):Cross((Vector3.new(v69, v72, v75)))) - 1
    if math.abs(v77) > 0.0001 then
        p64.CFrame = CFrame.new(v65, v66, v67, -v68, v69, v70, -v71, v72, v73, -v74, v75, v76)
        local v78 = p64.LeftSurface
        local v79 = p64.RightSurface
        p64.RightSurface = v78
        p64.LeftSurface = v79
    end
end
function InvertCornerWedgeOutwards(p80)
    local v81, v82, v83, v84, v85, v86, v87, v88, v89, v90, v91, v92 = p80.CFrame:components()
    local v93 = Vector3.new(v86, v89, v92):Dot(Vector3.new(v84, v87, v90):Cross((Vector3.new(v85, v88, v91)))) - 1
    if math.abs(v93) > 0.0001 then
        local v94 = p80.Size.z
        local v95 = p80.Size.y
        local v96 = p80.Size.x
        p80.Size = Vector3.new(v94, v95, v96)
        p80.CFrame = CFrame.new(v81, v82, v83, -v84, v85, v86, -v87, v88, v89, -v90, v91, v92) * CFrame.Angles(0, 1.5707963267948966, 0)
        local v97 = p80.LeftSurface
        local v98 = p80.RightSurface
        p80.RightSurface = v97
        p80.LeftSurface = v98
        local v99 = p80.FrontSurface
        local v100 = p80.RightSurface
        local v101 = p80.BackSurface
        local v102 = p80.LeftSurface
        p80.RightSurface = v99
        p80.BackSurface = v100
        p80.LeftSurface = v101
        p80.FrontSurface = v102
    end
end
function GenerateCuboid(p103, p104, p105, p106, p107, p108)
    local v109 = (p104 + p105 + p106 - p103) / 2
    local v110 = p104 - p103
    local v111 = p105 - p103
    local v112 = p106 - p103
    local v113 = p108:Clone()
    v113.Name = p108 and p108.Name or "Part"
    local v114 = v110.magnitude < globalMinThickness and globalMinThickness or v110.magnitude
    local v115 = v111.magnitude < globalMinThickness and globalMinThickness or v111.magnitude
    local v116 = v112.magnitude < globalMinThickness and globalMinThickness or v112.magnitude
    v113.Size = Vector3.new(v114, v115, v116)
    v113.CFrame = CFrame.new(v109.x, v109.y, v109.z, v110.x, v111.x, v112.x, v110.y, v111.y, v112.y, v110.z, v111.z, v112.z)
    InvertPartOutwards(v113)
    v113.Anchored = true
    v113.Parent = p107
    return v113
end
function GenerateRightAnglePrism(p117, p118, p119, p120, p121, p122)
    local v123 = (p118 + p119 + p120 - p117) / 2
    local v124 = p118 - p117
    local v125 = p119 - p117
    local v126 = p120 - p117
    local v127 = p122:Clone()
    v127.Name = p122 and p122.Name or "Wedge"
    local v128 = v124.magnitude < globalMinThickness and globalMinThickness or v124.magnitude
    local v129 = v125.magnitude < globalMinThickness and globalMinThickness or v125.magnitude
    local v130 = v126.magnitude < globalMinThickness and globalMinThickness or v126.magnitude
    v127.Size = Vector3.new(v128, v129, v130)
    v127.CFrame = CFrame.new(v123.x, v123.y, v123.z, v124.x, v125.x, v126.x, v124.y, v125.y, v126.y, v124.z, v125.z, v126.z)
    InvertPartOutwards(v127)
    v127.Anchored = true
    v127.Parent = p121
    return v127
end
function GenerateRightAngleCornerPrism(p131, p132, p133, p134, p135, p136)
    local v137 = (p132 + p133 + p134 - p131) / 2
    local v138 = p132 - p131
    local v139 = p133 - p131
    local v140 = p134 - p131
    local v141 = p136:Clone()
    v141.Name = p136 and p136.Name or "CornerWedge"
    local v142 = v138.magnitude < globalMinThickness and globalMinThickness or v138.magnitude
    local v143 = v139.magnitude < globalMinThickness and globalMinThickness or v139.magnitude
    local v144 = v140.magnitude < globalMinThickness and globalMinThickness or v140.magnitude
    v141.Size = Vector3.new(v142, v143, v144)
    v141.CFrame = CFrame.new(v137.x, v137.y, v137.z, v138.x, v139.x, v140.x, v138.y, v139.y, v140.y, v138.z, v139.z, v140.z)
    InvertCornerWedgeOutwards(v141)
    v141.Anchored = true
    v141.Parent = p135
    return v141
end
function GenerateParallelepiped(p145, p146, p147, p148, p149, p150)
    local v151 = { p148 - p145, p146 - p145, p147 - p145 }
    local v152 = Instance.new("Model")
    v152.Name = p150 and (p150.Name or "Part") or "Part"
    v152.Parent = p149
    local v153 = {
        p146,
        p147,
        p148,
        p146
    }
    local v154 = {
        { "Front" },
        { "Left" },
        { "Bottom" },
        { "Back" },
        { "Right" },
        { "Top" }
    }
    for v155 = 0, 1 do
        for v156 = 1, 3 do
            local v157, v158, v159 = GenerateParallelogram(p145 + v155 * v151[v156], v153[v156] + v155 * v151[v156], v153[v156 + 1] + v155 * v151[v156], v152)
            local v160 = v154[v156 + v155 * 3]
            table.insert(v160, v157)
            local v161 = v154[v156 + v155 * 3]
            table.insert(v161, v158)
            local v162 = v154[v156 + v155 * 3]
            table.insert(v162, v159)
        end
    end
    if p150 then
        for v163 = 1, 6 do
            for v164 = 2, 4 do
                v154[v163][v164].RightSurface = p150[v154[v163][1] .. "Surface"]
                v154[v163][v164].LeftSurface = p150[v154[v163][1] .. "Surface"]
                v154[v163][v164].Transparency = p150.Transparency
                v154[v163][v164].Reflectance = p150.Reflectance
                v154[v163][v164].Material = p150.Material
                v154[v163][v164].BrickColor = p150.BrickColor
                v154[v163][v164].Color = p150.Color
                v154[v163][v164].CanCollide = p150.CanCollide
            end
        end
    end
    return v152
end
function GeneratePrism(p165, p166, p167, p168, p169, p170)
    local v171 = {
        { p165, p166, p168 },
        { p168, p168 + p166 - p165, p168 + p167 - p165 },
        { p165, p166, p168 + p167 - p165 }
    }
    local v172 = {
        { p165, p168, p168 + p167 - p165 },
        { p166, p168 + p166 - p165, p168 + p166 + p167 - 2 * p165 }
    }
    local v173 = Instance.new("Model")
    v173.Name = p170 and (p170.Name or "Wedge") or "Wedge"
    v173.Parent = p169
    local v174 = {
        { "Bottom" },
        { "Back" },
        { "Front" },
        { "Left" },
        { "Right" }
    }
    for v175 = 1, 3 do
        local v176, v177, v178 = GenerateParallelogram(v171[v175][1], v171[v175][2], v171[v175][3], v173)
        local v179 = v174[v175]
        table.insert(v179, v176)
        local v180 = v174[v175]
        table.insert(v180, v177)
        local v181 = v174[v175]
        table.insert(v181, v178)
    end
    for v182 = 1, 2 do
        local v183, v184 = GenerateTriangle(v172[v182][1], v172[v182][2], v172[v182][3], v173)
        local v185 = v174[v182 + 3]
        table.insert(v185, v183)
        local v186 = v174[v182 + 3]
        table.insert(v186, v184)
    end
    if p170 then
        for v187 = 1, 5 do
            for v188 = 2, v187 < 4 and 4 or 3 do
                v174[v187][v188].RightSurface = p170[v174[v187][1] .. "Surface"]
                v174[v187][v188].LeftSurface = p170[v174[v187][1] .. "Surface"]
                v174[v187][v188].Transparency = p170.Transparency
                v174[v187][v188].Reflectance = p170.Reflectance
                v174[v187][v188].Material = p170.Material
                v174[v187][v188].BrickColor = p170.BrickColor
                v174[v187][v188].Color = p170.Color
                v174[v187][v188].CanCollide = p170.CanCollide
            end
        end
    end
    return v173
end
function GenerateCornerPrism(p189, p190, p191, p192, p193, p194)
    local v195 = {
        { "Bottom" },
        { "Back" },
        { "Front" },
        { "Left" },
        { "Right" }
    }
    local v196 = {
        { p189, p190, p192 }
    }
    local v197 = {
        { p192, p192 + p190 - p189, p190 + p191 - p189 },
        { p189, p190, p190 + p191 - p189 },
        { p189, p192, p190 + p191 - p189 },
        { p190, p190 + p192 - p189, p190 + p191 - p189 }
    }
    local v198 = Instance.new("Model")
    v198.Name = p194 and (p194.Name or "CornerWedge") or "CornerWedge"
    v198.Parent = p193
    local v199, v200, v201 = GenerateParallelogram(v196[1][1], v196[1][2], v196[1][3], v198)
    local v202 = v195[1]
    table.insert(v202, v199)
    local v203 = v195[1]
    table.insert(v203, v200)
    local v204 = v195[1]
    table.insert(v204, v201)
    for v205 = 1, 4 do
        local v206, v207 = GenerateTriangle(v197[v205][1], v197[v205][2], v197[v205][3], v198)
        local v208 = v195[v205 + 1]
        table.insert(v208, v206)
        local v209 = v195[v205 + 1]
        table.insert(v209, v207)
    end
    if p194 then
        for v210 = 1, 5 do
            for v211 = 2, v210 < 2 and 4 or 3 do
                v195[v210][v211].RightSurface = p194[v195[v210][1] .. "Surface"]
                v195[v210][v211].LeftSurface = p194[v195[v210][1] .. "Surface"]
                v195[v210][v211].Transparency = p194.Transparency
                v195[v210][v211].Reflectance = p194.Reflectance
                v195[v210][v211].Material = p194.Material
                v195[v210][v211].BrickColor = p194.BrickColor
                v195[v210][v211].Color = p194.Color
                v195[v210][v211].CanCollide = p194.CanCollide
            end
        end
    end
    return v198
end
function v1.GlobalTransform(p212, p213, p214, p215, p216, p217, p218, p219, p220, p221, p222, p223) --[[ Line: 300 ]]
    local v224 = p223 == nil and true or p223
    local v225 = p222 or Vector3.new(0, 0, 0)
    local v226 = {}
    local v227 = p221.CFrame
    local v228 = p221.Size.X / 2 * -1
    local v229 = p221.Size.Y / 2 * -1
    local v230 = p221.Size.Z / 2 * -1
    local v231 = v227:pointToWorldSpace((Vector3.new(v228, v229, v230))) - v225
    local v232 = p221.CFrame
    local v233 = p221.Size.X / 2 * 1
    local v234 = p221.Size.Y / 2 * -1
    local v235 = p221.Size.Z / 2 * -1
    local v236 = v232:pointToWorldSpace((Vector3.new(v233, v234, v235))) - v225
    local v237 = p221.CFrame
    local v238 = p221.Size.X / 2 * -1
    local v239 = p221.Size.Y / 2 * 1
    local v240 = p221.Size.Z / 2 * -1
    local v241 = v237:pointToWorldSpace((Vector3.new(v238, v239, v240))) - v225
    local v242 = p221.CFrame
    local v243 = p221.Size.X / 2 * -1
    local v244 = p221.Size.Y / 2 * -1
    local v245 = p221.Size.Z / 2 * 1
    __set_list(v226, 1, {v231, v236, v241, v242:pointToWorldSpace((Vector3.new(v243, v244, v245))) - v225})
    local v246 = {}
    for v247 = 1, 4 do
        local v248 = v226[v247]
        local v249 = p212 * v248.x + p213 * v248.y + p214 * v248.z
        local v250 = p215 * v248.x + p216 * v248.y + p217 * v248.z
        local v251 = p218 * v248.x + p219 * v248.y + p220 * v248.z
        v246[v247] = v225 + Vector3.new(v249, v250, v251)
    end
    if not v224 then
        return GenerateParallelepiped(v246[1], v246[2], v246[3], v246[4], p221.Parent, p221)
    end
    local v252 = 0
    for v253 = 1, 3 do
        local v254 = (v246[v253 + 1] - v246[1]).Unit:Dot((v246[v253 % 3 + 2] - v246[1]).Unit)
        if math.abs(v254) < mOVthreshold then
            v252 = v252 + 1
        end
    end
    if v252 == 3 then
        return GenerateCuboid(v246[1], v246[2], v246[3], v246[4], p221.Parent, p221)
    end
    local v255 = GenerateParallelepiped(v246[1], v246[2], v246[3], v246[4], p221.Parent, p221)
    local v256 = Instance.new("CFrameValue")
    v256.Parent = v255
    v256.Name = "Block"
    local v257 = v246[1]
    local v258 = v246[2] - v257
    local v259 = v246[3] - v257
    local v260 = v246[4] - v257
    v256.Value = CFrame.new(v257.x, v257.y, v257.z, v258.x, v259.x, v260.x, v258.y, v259.y, v260.y, v258.z, v259.z, v260.z)
    return v255
end
function v1.GlobalContinuousTransform(p261, p262, p263, p264, p265, p266, p267, p268, p269, p270, p271, p272) --[[ Line: 348 ]]
    local v273 = p271 or Vector3.new(0, 0, 0)
    local v274 = {
        p272.p - v273,
        p272.p + p272.rightVector - v273,
        p272.p + p272.upVector - v273,
        p272.p - p272.lookVector - v273
    }
    local v275 = {}
    for v276 = 1, 4 do
        local v277 = v274[v276]
        local v278 = p261 * v277.x + p262 * v277.y + p263 * v277.z
        local v279 = p264 * v277.x + p265 * v277.y + p266 * v277.z
        local v280 = p267 * v277.x + p268 * v277.y + p269 * v277.z
        v275[v276] = v273 + Vector3.new(v278, v279, v280)
    end
    local v281 = GenerateParallelepiped(v275[1], v275[2], v275[3], v275[4], p270.Parent, p270)
    local v282 = Instance.new("CFrameValue")
    v282.Parent = v281
    v282.Name = "Block"
    local v283 = v275[1]
    local v284 = v275[2] - v283
    local v285 = v275[3] - v283
    local v286 = v275[4] - v283
    v282.Value = CFrame.new(v283.x, v283.y, v283.z, v284.x, v285.x, v286.x, v284.y, v285.y, v286.y, v284.z, v285.z, v286.z)
    return v281
end
function v1.GlobalTransformWedge(p287, p288, p289, p290, p291, p292, p293, p294, p295, p296, p297, p298) --[[ Line: 380 ]]
    local v299 = p298 == nil and true or p298
    local v300 = p297 or Vector3.new(0, 0, 0)
    local v301 = {}
    local v302 = p296.CFrame
    local v303 = p296.Size.X / 2 * -1
    local v304 = p296.Size.Y / 2 * -1
    local v305 = p296.Size.Z / 2 * -1
    local v306 = v302:pointToWorldSpace((Vector3.new(v303, v304, v305))) - v300
    local v307 = p296.CFrame
    local v308 = p296.Size.X / 2 * 1
    local v309 = p296.Size.Y / 2 * -1
    local v310 = p296.Size.Z / 2 * -1
    local v311 = v307:pointToWorldSpace((Vector3.new(v308, v309, v310))) - v300
    local v312 = p296.CFrame
    local v313 = p296.Size.X / 2 * -1
    local v314 = p296.Size.Y / 2 * 1
    local v315 = p296.Size.Z / 2 * -1
    local v316 = v312:pointToWorldSpace((Vector3.new(v313, v314, v315))) - v300
    local v317 = p296.CFrame
    local v318 = p296.Size.X / 2 * -1
    local v319 = p296.Size.Y / 2 * -1
    local v320 = p296.Size.Z / 2 * 1
    __set_list(v301, 1, {v306, v311, v316, v317:pointToWorldSpace((Vector3.new(v318, v319, v320))) - v300})
    local v321 = {}
    for v322 = 1, 4 do
        local v323 = v301[v322]
        local v324 = p287 * v323.x + p288 * v323.y + p289 * v323.z
        local v325 = p290 * v323.x + p291 * v323.y + p292 * v323.z
        local v326 = p293 * v323.x + p294 * v323.y + p295 * v323.z
        v321[v322] = v300 + Vector3.new(v324, v325, v326)
    end
    if not v299 then
        return GeneratePrism(v321[1], v321[2], v321[3], v321[4], p296.Parent, p296)
    end
    local v327 = 0
    for v328 = 1, 3 do
        local v329 = (v321[v328 + 1] - v321[1]).Unit:Dot((v321[v328 % 3 + 2] - v321[1]).Unit)
        if math.abs(v329) < mOVthreshold then
            v327 = v327 + 1
        end
    end
    if v327 == 3 then
        return GenerateRightAnglePrism(v321[1], v321[2], v321[3], v321[4], p296.Parent, p296)
    end
    local v330 = GeneratePrism(v321[1], v321[2], v321[3], v321[4], p296.Parent, p296)
    local v331 = Instance.new("CFrameValue")
    v331.Parent = v330
    v331.Name = "WedgePart"
    local v332 = v321[1]
    local v333 = v321[2] - v332
    local v334 = v321[3] - v332
    local v335 = v321[4] - v332
    v331.Value = CFrame.new(v332.x, v332.y, v332.z, v333.x, v334.x, v335.x, v333.y, v334.y, v335.y, v333.z, v334.z, v335.z)
    return v330
end
function v1.GlobalContinuousWedgeTransform(p336, p337, p338, p339, p340, p341, p342, p343, p344, p345, p346, p347) --[[ Line: 428 ]]
    local v348 = p346 or Vector3.new(0, 0, 0)
    local v349 = {
        p347.p - v348,
        p347.p + p347.rightVector - v348,
        p347.p + p347.upVector - v348,
        p347.p - p347.lookVector - v348
    }
    local v350 = {}
    for v351 = 1, 4 do
        local v352 = v349[v351]
        local v353 = p336 * v352.x + p337 * v352.y + p338 * v352.z
        local v354 = p339 * v352.x + p340 * v352.y + p341 * v352.z
        local v355 = p342 * v352.x + p343 * v352.y + p344 * v352.z
        v350[v351] = v348 + Vector3.new(v353, v354, v355)
    end
    local v356 = GeneratePrism(v350[1], v350[2], v350[3], v350[4], p345.Parent, p345)
    local v357 = Instance.new("CFrameValue")
    v357.Parent = v356
    v357.Name = "WedgePart"
    local v358 = v350[1]
    local v359 = v350[2] - v358
    local v360 = v350[3] - v358
    local v361 = v350[4] - v358
    v357.Value = CFrame.new(v358.x, v358.y, v358.z, v359.x, v360.x, v361.x, v359.y, v360.y, v361.y, v359.z, v360.z, v361.z)
    return v356
end
function v1.GlobalTransformCornerWedge(p362, p363, p364, p365, p366, p367, p368, p369, p370, p371, p372, p373) --[[ Line: 460 ]]
    local v374 = p373 == nil and true or p373
    local v375 = p372 or Vector3.new(0, 0, 0)
    local v376 = {}
    local v377 = p371.CFrame
    local v378 = p371.Size.X / 2 * -1
    local v379 = p371.Size.Y / 2 * -1
    local v380 = p371.Size.Z / 2 * -1
    local v381 = v377:pointToWorldSpace((Vector3.new(v378, v379, v380))) - v375
    local v382 = p371.CFrame
    local v383 = p371.Size.X / 2 * 1
    local v384 = p371.Size.Y / 2 * -1
    local v385 = p371.Size.Z / 2 * -1
    local v386 = v382:pointToWorldSpace((Vector3.new(v383, v384, v385))) - v375
    local v387 = p371.CFrame
    local v388 = p371.Size.X / 2 * -1
    local v389 = p371.Size.Y / 2 * 1
    local v390 = p371.Size.Z / 2 * -1
    local v391 = v387:pointToWorldSpace((Vector3.new(v388, v389, v390))) - v375
    local v392 = p371.CFrame
    local v393 = p371.Size.X / 2 * -1
    local v394 = p371.Size.Y / 2 * -1
    local v395 = p371.Size.Z / 2 * 1
    __set_list(v376, 1, {v381, v386, v391, v392:pointToWorldSpace((Vector3.new(v393, v394, v395))) - v375})
    local v396 = {}
    for v397 = 1, 4 do
        local v398 = v376[v397]
        local v399 = p362 * v398.x + p363 * v398.y + p364 * v398.z
        local v400 = p365 * v398.x + p366 * v398.y + p367 * v398.z
        local v401 = p368 * v398.x + p369 * v398.y + p370 * v398.z
        v396[v397] = v375 + Vector3.new(v399, v400, v401)
    end
    if not v374 then
        return GenerateCornerPrism(v396[1], v396[2], v396[3], v396[4], p371.Parent, p371)
    end
    local v402 = 0
    for v403 = 1, 3 do
        local v404 = (v396[v403 + 1] - v396[1]).Unit:Dot((v396[v403 % 3 + 2] - v396[1]).Unit)
        if math.abs(v404) < mOVthreshold then
            v402 = v402 + 1
        end
    end
    if v402 == 3 then
        return GenerateRightAngleCornerPrism(v396[1], v396[2], v396[3], v396[4], p371.Parent, p371)
    end
    local v405 = GenerateCornerPrism(v396[1], v396[2], v396[3], v396[4], p371.Parent, p371)
    local v406 = Instance.new("CFrameValue")
    v406.Parent = v405
    v406.Name = "CornerWedgePart"
    local v407 = v396[1]
    local v408 = v396[2] - v407
    local v409 = v396[3] - v407
    local v410 = v396[4] - v407
    v406.Value = CFrame.new(v407.x, v407.y, v407.z, v408.x, v409.x, v410.x, v408.y, v409.y, v410.y, v408.z, v409.z, v410.z)
    return v405
end
function v1.GlobalContinuousCornerWedgeTransform(p411, p412, p413, p414, p415, p416, p417, p418, p419, p420, p421, p422) --[[ Line: 508 ]]
    local v423 = p421 or Vector3.new(0, 0, 0)
    local v424 = {
        p422.p - v423,
        p422.p + p422.rightVector - v423,
        p422.p + p422.upVector - v423,
        p422.p - p422.lookVector - v423
    }
    local v425 = {}
    for v426 = 1, 4 do
        local v427 = v424[v426]
        local v428 = p411 * v427.x + p412 * v427.y + p413 * v427.z
        local v429 = p414 * v427.x + p415 * v427.y + p416 * v427.z
        local v430 = p417 * v427.x + p418 * v427.y + p419 * v427.z
        v425[v426] = v423 + Vector3.new(v428, v429, v430)
    end
    local v431 = GenerateCornerPrism(v425[1], v425[2], v425[3], v425[4], p420.Parent, p420)
    local v432 = Instance.new("CFrameValue")
    v432.Parent = v431
    v432.Name = "CornerWedgePart"
    local v433 = v425[1]
    local v434 = v425[2] - v433
    local v435 = v425[3] - v433
    local v436 = v425[4] - v433
    v432.Value = CFrame.new(v433.x, v433.y, v433.z, v434.x, v435.x, v436.x, v434.y, v435.y, v436.y, v434.z, v435.z, v436.z)
    return v431
end
function v1.GlobalOrthogonalTransform(p437, p438, p439, p440, p441, p442, p443, p444, p445, p446, p447, p448) --[[ Line: 540 ]]
    local v449 = p448 == nil and true or p448
    local v450 = p447 or Vector3.new(0, 0, 0)
    local v451 = {}
    local v452 = p446.CFrame
    local v453 = p446.Size.X / 2 * -1
    local v454 = p446.Size.Y / 2 * -1
    local v455 = p446.Size.Z / 2 * -1
    local v456 = v452:pointToWorldSpace((Vector3.new(v453, v454, v455))) - v450
    local v457 = p446.CFrame
    local v458 = p446.Size.X / 2 * 1
    local v459 = p446.Size.Y / 2 * -1
    local v460 = p446.Size.Z / 2 * -1
    local v461 = v457:pointToWorldSpace((Vector3.new(v458, v459, v460))) - v450
    local v462 = p446.CFrame
    local v463 = p446.Size.X / 2 * -1
    local v464 = p446.Size.Y / 2 * 1
    local v465 = p446.Size.Z / 2 * -1
    local v466 = v462:pointToWorldSpace((Vector3.new(v463, v464, v465))) - v450
    local v467 = p446.CFrame
    local v468 = p446.Size.X / 2 * -1
    local v469 = p446.Size.Y / 2 * -1
    local v470 = p446.Size.Z / 2 * 1
    __set_list(v451, 1, {v456, v461, v466, v467:pointToWorldSpace((Vector3.new(v468, v469, v470))) - v450})
    local v471 = {}
    for v472 = 1, 4 do
        local v473 = v451[v472]
        local v474 = p437 * v473.x + p438 * v473.y + p439 * v473.z
        local v475 = p440 * v473.x + p441 * v473.y + p442 * v473.z
        local v476 = p443 * v473.x + p444 * v473.y + p445 * v473.z
        v471[v472] = v450 + Vector3.new(v474, v475, v476)
    end
    if v449 then
        return GenerateCuboid(v471[1], v471[2], v471[3], v471[4], p446.Parent, p446)
    else
        return GenerateParallelepiped(v471[1], v471[2], v471[3], v471[4], p446.Parent, p446)
    end
end
return v1