 
-- Decompiled on 2026-04-08 19:43:26
-- Luau version 6, Types version 3
-- Time taken: 0.016377 seconds

local Bezier = require(script.Bezier)
local function RevBack(arg1) -- Line 3
	local var2 = 1 - arg1
	return (1) - (math.sin(var2 * (math.pi/2)) + math.sin(var2 * math.pi) * (math.cos(var2 * math.pi) + 1) / 2)
end
local var1_result1_3 = Bezier(0.4, 0, 0.6, 1)
local var1_result1 = Bezier(0.4, 0, 0.2, 1)
local var1_result1_5 = Bezier(0.4, 0, 1, 1)
local Bezier_result1_8 = Bezier(0, 0, 0.2, 1)
local Bezier_result1_9 = Bezier(0.8, 0, 0.2, 1)
local Bezier_result1_7 = Bezier(0.9, 0.1, 1, 0.2)
local Bezier_result1_6 = Bezier(0.1, 0.9, 0.2, 1)
local var1_result1_2 = Bezier(0.7, 0, 1, 0.5)
local var1_result1_6 = Bezier(0.2, 0, 0.38, 0.9)
local Bezier_result1_4 = Bezier(0.4, 0.14, 0.3, 1)
local var1_result1_4 = Bezier(0, 0, 0.38, 0.9)
local Bezier_result1_2 = Bezier(0, 0, 0.3, 1)
local Bezier_result1_5 = Bezier(0.2, 0, 1, 0.9)
local Bezier_result1 = Bezier(0.4, 0.14, 1, 1)
local Bezier_result1_3 = Bezier(0.07, 0.95, 0, 1)
local function Smooth(arg1) -- Line 44
	return arg1 * arg1 * (3 - 2 * arg1)
end
local function Smoother(arg1) -- Line 48
	return arg1 * arg1 * arg1 * (arg1 * (6 * arg1 - 15) + 10)
end
local function RidiculousWiggle(arg1) -- Line 52
	return math.sin(math.sin(arg1 * math.pi) * (math.pi/2))
end
local function Spring(arg1) -- Line 56
	return -math.exp(-6.9 * arg1) * math.cos(-20.106192982974676 * arg1) + 1
end
local function SoftSpring(arg1) -- Line 60
	return -math.exp(-7.5 * arg1) * math.cos(-10.053096491487338 * arg1) + 1
end
return setmetatable({
	Linear = function(arg1) -- Line 10, Named "Linear"
		return arg1
	end;
	OutSmooth = Smooth;
	InSmooth = Smooth;
	InOutSmooth = Smooth;
	OutSmoother = Smoother;
	InSmoother = Smoother;
	InOutSmoother = Smoother;
	OutRidiculousWiggle = RidiculousWiggle;
	InRidiculousWiggle = RidiculousWiggle;
	InOutRidiculousWiggle = RidiculousWiggle;
	OutRevBack = RevBack;
	InRevBack = RevBack;
	InOutRevBack = RevBack;
	OutSpring = Spring;
	InSpring = Spring;
	InOutSpring = Spring;
	OutSoftSpring = SoftSpring;
	InSoftSpring = SoftSpring;
	InOutSoftSpring = SoftSpring;
	InSharp = var1_result1_3;
	InOutSharp = var1_result1_3;
	OutSharp = var1_result1_3;
	InAcceleration = var1_result1_5;
	InOutAcceleration = var1_result1_5;
	OutAcceleration = var1_result1_5;
	InStandard = var1_result1;
	InOutStandard = var1_result1;
	OutStandard = var1_result1;
	InDeceleration = Bezier_result1_8;
	InOutDeceleration = Bezier_result1_8;
	OutDeceleration = Bezier_result1_8;
	InFabricStandard = Bezier_result1_9;
	InOutFabricStandard = Bezier_result1_9;
	OutFabricStandard = Bezier_result1_9;
	InFabricAccelerate = Bezier_result1_7;
	InOutFabricAccelerate = Bezier_result1_7;
	OutFabricAccelerate = Bezier_result1_7;
	InFabricDecelerate = Bezier_result1_6;
	InOutFabricDecelerate = Bezier_result1_6;
	OutFabricDecelerate = Bezier_result1_6;
	InUWPAccelerate = var1_result1_2;
	InOutUWPAccelerate = var1_result1_2;
	OutUWPAccelerate = var1_result1_2;
	InStandardProductive = var1_result1_6;
	OutStandardProductive = var1_result1_6;
	InOutStandardProductive = var1_result1_6;
	InStandardExpressive = Bezier_result1_4;
	OutStandardExpressive = Bezier_result1_4;
	InOutStandardExpressive = Bezier_result1_4;
	InEntranceProductive = var1_result1_4;
	OutEntranceProductive = var1_result1_4;
	InOutEntranceProductive = var1_result1_4;
	InEntranceExpressive = Bezier_result1_2;
	OutEntranceExpressive = Bezier_result1_2;
	InOutEntranceExpressive = Bezier_result1_2;
	InExitProductive = Bezier_result1_5;
	OutExitProductive = Bezier_result1_5;
	InOutExitProductive = Bezier_result1_5;
	InExitExpressive = Bezier_result1;
	OutExitExpressive = Bezier_result1;
	InOutExitExpressive = Bezier_result1;
	OutMozillaCurve = Bezier_result1_3;
	InMozillaCurve = Bezier_result1_3;
	InOutMozillaCurve = Bezier_result1_3;
	InQuad = function(arg1) -- Line 172, Named "InQuad"
		return arg1 * arg1
	end;
	OutQuad = function(arg1) -- Line 176, Named "OutQuad"
		return arg1 * (2 - arg1)
	end;
	InOutQuad = function(arg1) -- Line 180, Named "InOutQuad"
		local var21
		local function INLINED_4() -- Internal function, doesn't exist in bytecode
			var21 = 2 * arg1 * arg1
			return var21
		end
		if arg1 >= 0.5 or not INLINED_4() then
			var21 = 2 * (2 - arg1) * arg1 - 1
		end
		return var21
	end;
	InCubic = function(arg1) -- Line 184, Named "InCubic"
		return arg1 * arg1 * arg1
	end;
	OutCubic = function(arg1) -- Line 188, Named "OutCubic"
		return 1 - (1 - arg1) * (1 - arg1) * (1 - arg1)
	end;
	InOutCubic = function(arg1) -- Line 192, Named "InOutCubic"
		local var22
		local function INLINED_5() -- Internal function, doesn't exist in bytecode
			var22 = 4 * arg1 * arg1 * arg1
			return var22
		end
		if arg1 >= 0.5 or not INLINED_5() then
			var22 = 1 + 4 * (arg1 - 1) * (arg1 - 1) * (arg1 - 1)
		end
		return var22
	end;
	InQuart = function(arg1) -- Line 196, Named "InQuart"
		return arg1 * arg1 * arg1 * arg1
	end;
	OutQuart = function(arg1) -- Line 200, Named "OutQuart"
		local var23 = arg1 - 1
		return 1 - var23 * var23 * var23 * var23
	end;
	InOutQuart = function(arg1) -- Line 205, Named "InOutQuart"
		if arg1 < 0.5 then
			local var24 = arg1 * arg1
			return 8 * var24 * var24
		end
		local var25 = var24 - 1
		return 1 - 8 * var25 * var25 * var25 * var25
	end;
	InQuint = function(arg1) -- Line 215, Named "InQuint"
		return arg1 * arg1 * arg1 * arg1 * arg1
	end;
	OutQuint = function(arg1) -- Line 219, Named "OutQuint"
		local var26 = arg1 - 1
		return var26 * var26 * var26 * var26 * var26 + 1
	end;
	InOutQuint = function(arg1) -- Line 224, Named "InOutQuint"
		if arg1 < 0.5 then
			return 16 * arg1 * arg1 * arg1 * arg1 * arg1
		end
		local var27 = arg1 - 1
		return 16 * var27 * var27 * var27 * var27 * var27 + 1
	end;
	InBack = function(arg1) -- Line 233, Named "InBack"
		return arg1 * arg1 * (3 * arg1 - 2)
	end;
	OutBack = function(arg1) -- Line 237, Named "OutBack"
		return (arg1 - 1) * (arg1 - 1) * (arg1 * 2 + arg1 - 1) + 1
	end;
	InOutBack = function(arg1) -- Line 241, Named "InOutBack"
		local var28
		local function INLINED_6() -- Internal function, doesn't exist in bytecode
			var28 = 2 * arg1 * arg1 * (6 * arg1 - 2)
			return var28
		end
		if arg1 >= 0.5 or not INLINED_6() then
			var28 = 1 + 2 * (arg1 - 1) * (arg1 - 1) * (6 * arg1 - 2 - 2)
		end
		return var28
	end;
	InSine = function(arg1) -- Line 245, Named "InSine"
		return 1 - math.cos(arg1 * (math.pi/2))
	end;
	OutSine = function(arg1) -- Line 249, Named "OutSine"
		return math.sin(arg1 * (math.pi/2))
	end;
	InOutSine = function(arg1) -- Line 253, Named "InOutSine"
		return (1 - math.cos(math.pi * arg1)) / 2
	end;
	OutBounce = function(arg1) -- Line 64, Named "OutBounce"
		local var18
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var18 = 7.5625 * arg1 * arg1
			return var18
		end
		local function INLINED_2() -- Internal function, doesn't exist in bytecode
			var18 = 3 + arg1 * (11 * arg1 - 12) * 0.6875
			return var18
		end
		local function INLINED_3() -- Internal function, doesn't exist in bytecode
			var18 = 6 + arg1 * (11 * arg1 - 18) * 0.6875
			return var18
		end
		if arg1 >= 0.36363636363636365 or not INLINED() or arg1 >= 0.7272727272727273 or not INLINED_2() or arg1 >= 0.9090909090909091 or not INLINED_3() then
			var18 = 7.875 + arg1 * (11 * arg1 - 21) * 0.6875
		end
		return var18
	end;
	InBounce = function(arg1) -- Line 71, Named "InBounce"
		if 0.6363636363636364 < arg1 then
			local var19 = arg1 - 1
			return 1 - var19 * var19 * 7.5625
		end
		if 0.2727272727272727 < var19 then
			return (11 * var19 - 7) * (11 * var19 - 3) / -16
		end
		if 0.09090909090909091 < var19 then
			return (11 * (4 - 11 * var19) * var19 - 3) / 16
		end
		return var19 * (11 * var19 - 1) * -0.6875
	end;
	InOutBounce = function(arg1) -- Line 260, Named "InOutBounce"
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		local var29
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [3] 3. Error Block 40 start (CF ANALYSIS FAILED)
		local var30 = 2 * arg1
		if 0.6363636363636364 < var30 then
			local var31 = var30 - 1
			var29 = 1 - var31 * var31 * 7.5625
		elseif 0.2727272727272727 < var31 then
			var29 = (11 * var31 - 7) * (11 * var31 - 3) / -16
		elseif 0.09090909090909091 < var31 then
			var29 = (11 * (4 - 11 * var31) * var31 - 3) / 16
		else
			var29 = var31 * (11 * var31 - 1) * -0.6875
		end
		local var32
		if not (var29 / 2) then
			-- KONSTANTERROR: [44] 41. Error Block 34 start (CF ANALYSIS FAILED)
			local var33 = 2 * arg1 - 1
			local function INLINED_7() -- Internal function, doesn't exist in bytecode
				var32 = 7.5625 * var33 * var33
				return var32
			end
			local function INLINED_8() -- Internal function, doesn't exist in bytecode
				var32 = 3 + var33 * (11 * var33 - 12) * 0.6875
				return var32
			end
			local function INLINED_9() -- Internal function, doesn't exist in bytecode
				var32 = 6 + var33 * (11 * var33 - 18) * 0.6875
				return var32
			end
			if var33 >= 0.36363636363636365 or not INLINED_7() or var33 >= 0.7272727272727273 or not INLINED_8() or var33 >= 0.9090909090909091 or not INLINED_9() then
				var32 = 7.875 + var33 * (11 * var33 - 21) * 0.6875
			end
			var29 = var32 / 2
			-- KONSTANTERROR: [44] 41. Error Block 34 end (CF ANALYSIS FAILED)
		end
		do
			return var29 + 0.5
		end
		-- KONSTANTERROR: [3] 3. Error Block 40 end (CF ANALYSIS FAILED)
	end;
	InElastic = function(arg1) -- Line 264, Named "InElastic"
		return math.exp((arg1 * 0.9638073641881153 - 1) * 8) * arg1 * 0.9638073641881153 * math.sin(4 * arg1 * 0.9638073641881153) * 1.8752275007428716
	end;
	OutElastic = function(arg1) -- Line 270, Named "OutElastic"
		return 1 + math.exp(8 * (0.9638073641881153 - 0.9638073641881153 * arg1 - 1)) * 0.9638073641881153 * (arg1 - 1) * math.sin(3.855229456752461 * (1 - arg1)) * 1.8752275007428716
	end;
	InOutElastic = function(arg1) -- Line 277, Named "InOutElastic"
		local var34
		local function INLINED_10() -- Internal function, doesn't exist in bytecode
			var34 = math.exp(8 * (1.9276147283762306 * arg1 - 1)) * 0.9638073641881153 * arg1 * math.sin(7.710458913504922 * arg1) * 1.8752275007428716
			return var34
		end
		if arg1 >= 0.5 or not INLINED_10() then
			var34 = 1 + math.exp(8 * (0.9638073641881153 * (2 - 2 * arg1) - 1)) * 0.9638073641881153 * (arg1 - 1) * math.sin(3.855229456752461 * (2 - 2 * arg1)) * 1.8752275007428716
		end
		return var34
	end;
	InExponential = function(arg1) -- Line 282, Named "InExponential"
		return arg1 * arg1 * math.exp(4 * (arg1 - 1))
	end;
	OutExponential = function(arg1) -- Line 286, Named "OutExponential"
		return 1 - (1 - arg1) * (1 - arg1) / math.exp(4 * arg1)
	end;
	InOutExponential = function(arg1) -- Line 290, Named "InOutExponential"
		local var35
		local function INLINED_11() -- Internal function, doesn't exist in bytecode
			var35 = 2 * arg1 * arg1 * math.exp(4 * (2 * arg1 - 1))
			return var35
		end
		if arg1 >= 0.5 or not INLINED_11() then
			var35 = 1 - 2 * (arg1 - 1) * (arg1 - 1) * math.exp(4 * (1 - 2 * arg1))
		end
		return var35
	end;
	InCircular = function(arg1) -- Line 294, Named "InCircular"
		return -(math.sqrt(1 - arg1 * arg1) - 1)
	end;
	OutCircular = function(arg1) -- Line 298, Named "OutCircular"
		local var36 = arg1 - 1
		return math.sqrt(1 - var36 * var36)
	end;
	InOutCircular = function(arg1) -- Line 303, Named "InOutCircular"
		local var37 = arg1 * 2
		if var37 < 1 then
			return -(math.sqrt(1 - var37 * var37) - 1) / 2
		end
		local var38 = var37 - 2
		return (math.sqrt(1 - var38 * var38) - 1) / 2
	end;
}, {
	__index = function(arg1, arg2) -- Line 313, Named "__index"
		error(tostring(arg2).." is not a valid easing style.", 2)
	end;
})