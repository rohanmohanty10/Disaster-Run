local BoatTween = {}

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Valid step types for the tween heartbeat
local VALID_STEP_TYPES = {
	Heartbeat    = true,
	Stepped      = true,
	RenderStepped = true,
}

-- RenderStepped is client-only
if not RunService:IsClient() then
	VALID_STEP_TYPES.RenderStepped = nil
end

local TweenFunctions = require(script.TweenFunctions)
local Lerps          = require(script.Lerps)
local Trove          = require(ReplicatedStorage.Modules.Trove)
local GoodSignal     = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.GoodSignal)

-- Maps easing style names to their In/Out/InOut functions
local EasingStyles = {
	Linear           = { In = TweenFunctions.Linear,                  Out = TweenFunctions.Linear,                   InOut = TweenFunctions.Linear                   },
	Quad             = { In = TweenFunctions.InQuad,                   Out = TweenFunctions.OutQuad,                  InOut = TweenFunctions.InOutQuad                 },
	Cubic            = { In = TweenFunctions.InCubic,                  Out = TweenFunctions.OutCubic,                 InOut = TweenFunctions.InOutCubic                },
	Quart            = { In = TweenFunctions.InQuart,                  Out = TweenFunctions.OutQuart,                 InOut = TweenFunctions.InOutQuart                },
	Quint            = { In = TweenFunctions.InQuint,                  Out = TweenFunctions.OutQuint,                 InOut = TweenFunctions.InOutQuint                },
	Sine             = { In = TweenFunctions.InSine,                   Out = TweenFunctions.OutSine,                  InOut = TweenFunctions.InOutSine                 },
	Exponential      = { In = TweenFunctions.InExponential,            Out = TweenFunctions.OutExponential,           InOut = TweenFunctions.InOutExponential          },
	Expo             = { In = TweenFunctions.InExponential,            Out = TweenFunctions.OutExponential,           InOut = TweenFunctions.InOutExponential          },
	Circular         = { In = TweenFunctions.InCircular,               Out = TweenFunctions.OutCircular,              InOut = TweenFunctions.InOutCircular             },
	Elastic          = { In = TweenFunctions.InElastic,                Out = TweenFunctions.OutElastic,               InOut = TweenFunctions.InOutElastic              },
	Back             = { In = TweenFunctions.InBack,                   Out = TweenFunctions.OutBack,                  InOut = TweenFunctions.InOutBack                 },
	Bounce           = { In = TweenFunctions.InBounce,                 Out = TweenFunctions.OutBounce,                InOut = TweenFunctions.InOutBounce               },
	Smooth           = { In = TweenFunctions.InSmooth,                 Out = TweenFunctions.OutSmooth,                InOut = TweenFunctions.InOutSmooth               },
	Smoother         = { In = TweenFunctions.InSmoother,               Out = TweenFunctions.OutSmoother,              InOut = TweenFunctions.InOutSmoother             },
	RidiculousWiggle = { In = TweenFunctions.InRidiculousWiggle,       Out = TweenFunctions.OutRidiculousWiggle,      InOut = TweenFunctions.InOutRidiculousWiggle     },
	RevBack          = { In = TweenFunctions.InRevBack,                Out = TweenFunctions.OutRevBack,               InOut = TweenFunctions.InOutRevBack              },
	Spring           = { In = TweenFunctions.InSpring,                 Out = TweenFunctions.OutSpring,                InOut = TweenFunctions.InOutSpring               },
	SoftSpring       = { In = TweenFunctions.InSoftSpring,             Out = TweenFunctions.OutSoftSpring,            InOut = TweenFunctions.InOutSoftSpring           },
	Sharp            = { In = TweenFunctions.InSharp,                  Out = TweenFunctions.OutSharp,                 InOut = TweenFunctions.InOutSharp                },
	Acceleration     = { In = TweenFunctions.InAcceleration,           Out = TweenFunctions.OutAcceleration,          InOut = TweenFunctions.InOutAcceleration         },
	Standard         = { In = TweenFunctions.InStandard,               Out = TweenFunctions.OutStandard,              InOut = TweenFunctions.InOutStandard             },
	Deceleration     = { In = TweenFunctions.InDeceleration,           Out = TweenFunctions.OutDeceleration,          InOut = TweenFunctions.InOutDeceleration         },
	FabricStandard   = { In = TweenFunctions.InFabricStandard,         Out = TweenFunctions.OutFabricStandard,        InOut = TweenFunctions.InOutFabricStandard       },
	FabricAccelerate = { In = TweenFunctions.InFabricAccelerate,       Out = TweenFunctions.OutFabricAccelerate,      InOut = TweenFunctions.InOutFabricAccelerate     },
	FabricDecelerate = { In = TweenFunctions.InFabricDecelerate,       Out = TweenFunctions.OutFabricDecelerate,      InOut = TweenFunctions.InOutFabricDecelerate     },
	UWPAccelerate    = { In = TweenFunctions.InUWPAccelerate,          Out = TweenFunctions.OutUWPAccelerate,         InOut = TweenFunctions.InOutUWPAccelerate        },
	StandardProductive  = { In = TweenFunctions.InStandardProductive,  Out = TweenFunctions.OutStandardProductive,   InOut = TweenFunctions.InOutStandardProductive   },
	EntranceProductive  = { In = TweenFunctions.InEntranceProductive,  Out = TweenFunctions.OutEntranceProductive,   InOut = TweenFunctions.InOutEntranceProductive   },
	ExitProductive      = { In = TweenFunctions.InExitProductive,      Out = TweenFunctions.OutExitProductive,       InOut = TweenFunctions.InOutExitProductive       },
	StandardExpressive  = { In = TweenFunctions.InStandardExpressive,  Out = TweenFunctions.OutStandardExpressive,   InOut = TweenFunctions.InOutStandardExpressive   },
	EntranceExpressive  = { In = TweenFunctions.InEntranceExpressive,  Out = TweenFunctions.OutEntranceExpressive,   InOut = TweenFunctions.InOutEntranceExpressive   },
	ExitExpressive      = { In = TweenFunctions.InExitExpressive,      Out = TweenFunctions.OutExitExpressive,       InOut = TweenFunctions.InOutExitExpressive       },
	MozillaCurve        = { In = TweenFunctions.InMozillaCurve,        Out = TweenFunctions.OutMozillaCurve,         InOut = TweenFunctions.InOutMozillaCurve         },
}

--[[
    Creates and returns a tween object.

    Parameters:
        tweenId  - arbitrary identifier (unused internally, kept for API parity)
        instance - the Instance to tween properties on
        config   - table with the following optional fields:
            .Time               (number)  duration in seconds          [default: 1]
            .Goal               (table)   property → target value map  [default: {}]
            .EasingStyle        (string)  key into EasingStyles        [default: "Quad"]
            .EasingDirection    (string)  "In" / "Out" / "InOut"       [default: "In"]
            .Reverses           (bool)    ping-pong back after forward pass
            .RepeatCount        (number)  times to repeat (-1=infinite) [default: 0]
            .DelayTime          (number)  seconds to wait before each play
            .StepType           (string)  "Heartbeat"/"Stepped"/"RenderStepped"
            .CustomEventStepFreq(number)  if set, steps on a timer instead of RunService

    Returns a tween object with:
        .Instance       - the tweened instance
        .PlaybackState  - Enum.PlaybackState
        .Completed      - GoodSignal fired when the tween fully finishes
        .Stopped        - GoodSignal fired when :Stop() is called
        .Resumed        - GoodSignal fired when :Resume() is called
        :Play()         - starts the tween from the beginning
        :Stop()         - cancels mid-tween
        :Resume()       - continues from where it was stopped
        :Destroy()      - cleans up all connections and signals
]]
function BoatTween.Create(tweenId, instance, config)
	if not instance or typeof(instance) ~= "Instance" then
		error("BoatTween.Create: invalid instance: " .. tostring(instance))
		return
	end

	local settings = type(config) == "table" and config or {}

	-- Resolve which RunService event to step on
	local stepType = settings.StepType
	local stepEvent
	if VALID_STEP_TYPES[stepType] and RunService[stepType] then
		stepEvent = RunService[stepType]
	else
		stepEvent = RunService.Heartbeat
	end

	-- Tween duration, clamped to a sane range
	local duration = type(settings.Time) == "number"
		and math.clamp(settings.Time, 0.001, 9999999999)
		or 1

	-- Property → target value map
	local goalProperties = type(settings.Goal) == "table" and settings.Goal or {}

	-- Optional delay before each play
	local delayTime
	if type(settings.DelayTime) == "number" and settings.DelayTime > 0.027 then
		delayTime = settings.DelayTime
	end

	-- How many times to repeat (+1 for internal layer counting; -1 = infinite)
	local maxRepeats = (type(settings.RepeatCount) == "number"
		and math.clamp(settings.RepeatCount, -1, 999999999)
		or 0) + 1

	local customStepFrequency = settings.CustomEventStepFreq

	-- Build parallel arrays of property names and their lerp functions
	-- so we can iterate numerically during the hot update loop
	local propertyNames  = {}
	local propertyLerps  = {}
	local propertyCount  = 0

	goalProperties.CustomEventStepFreq = nil -- strip internal key if present

	for propertyName, targetValue in goalProperties do
		local ok, currentValue = pcall(function()
			return instance[propertyName]
		end)
		if not ok or currentValue == nil then
			error("BoatTween.Create: property '" .. propertyName
				.. "' does not exist or is inaccessible on " .. tostring(instance))
		end
		propertyCount += 1
		propertyNames[propertyCount] = propertyName
		propertyLerps[propertyCount] = Lerps[typeof(targetValue)](currentValue, targetValue)
	end

	-- Trove for lifecycle management; three signals for tween events
	local trove       = Trove.new()
	local onCompleted = trove:Construct(GoodSignal)
	local onResumed   = trove:Construct(GoodSignal)
	local onStopped   = trove:Construct(GoodSignal)

	-- Optional custom-frequency step signal
	local customStepSignal
	if customStepFrequency then
		customStepSignal = trove:Construct(GoodSignal)
		trove:Add(task.spawn(function()
			while task.wait(customStepFrequency) do
				customStepSignal:Fire()
			end
		end))
	end

	-- Tween state
	local stepConnection  = nil
	local elapsed         = 0
	local startTick       = tick()
	local isDestroyed     = false
	local isCompleted     = false
	local currentLayer    = 0   -- which repeat iteration we're on
	local isReversing     = false

	local inverseDirection = 1 / duration
	--local easingFunction  = EasingStyles[settings.EasingStyle or "Quad"][settings.EasingDirection or "In"]
	local easingFunction = (EasingStyles[settings.EasingStyle or "Quad"] 
		and EasingStyles[settings.EasingStyle or "Quad"][settings.EasingDirection or "In"])
		or EasingStyles["Quad"]["In"]
	local reverses        = settings.Reverses

	-- The tween object returned to the caller
	local tween = {}
	tween.Instance      = instance
	tween.PlaybackState = Enum.PlaybackState.Begin
	tween.Completed     = onCompleted
	tween.Resumed       = onResumed
	tween.Stopped       = onStopped

	-- Fires Completed signal and cleans up unless the caller is managing lifetime
	local function fireCompleted()
		if isCompleted then return end
		isCompleted = true
		tween.PlaybackState = Enum.PlaybackState.Completed
		onCompleted:Fire()
		if not isDestroyed and tween.Destroy then
			tween:Destroy()
		end
	end

	function tween:Destroy()
		if isDestroyed then return end
		isDestroyed = true
		isCompleted = true
		if stepConnection then
			stepConnection:Disconnect()
			stepConnection = nil
		end
		onStopped:DisconnectAll()
		onResumed:DisconnectAll()
		onCompleted:DisconnectAll()
		trove:Destroy()
		table.clear(propertyNames)
		table.clear(propertyLerps)
		table.clear(goalProperties)
		table.clear(tween)
	end

	-- Clean up if the instance is destroyed mid-tween
	trove:Connect(instance.Destroying, function()
		tween:Destroy()
	end)

	-- Internal play function; layer tracks which repeat we're on, reversing = true means ping-pong return pass
	local function playLayer(layer, reversing)
		if instance ~= nil and not instance:IsDescendantOf(game) then
			fireCompleted()
			return
		end

		-- Stop if we've exhausted all repeats (0 = infinite)
		if maxRepeats ~= 0 and maxRepeats < layer then
			fireCompleted()
			isReversing = false
			currentLayer = 1
			return
		end

		currentLayer = layer
		if reversing then
			isReversing = true
		end

		if delayTime then
			tween.PlaybackState = Enum.PlaybackState.Delayed
			task.wait(delayTime)
		end

		startTick = tick() - elapsed

		-- Use custom step signal if provided
		if customStepSignal then
			stepEvent = customStepSignal
		end

		if isDestroyed then return end

		stepConnection = stepEvent:Connect(function()
			elapsed = tick() - startTick

			if duration <= elapsed then
				-- Snap to final value (reversed = snap to start, forward = snap to end)
				for i = 1, propertyCount do
					instance[propertyNames[i]] = propertyLerps[i](reversing and 0 or 1)
				end

				stepConnection:Disconnect()
				stepConnection = nil
				elapsed = 0

				if reversing then
					-- Finished the reverse pass; move to next repeat
					playLayer(layer + 1, false)
				elseif reverses then
					-- Start the reverse pass of this layer
					playLayer(layer, true)
				else
					playLayer(layer + 1, false)
				end
				return
			end

			-- Compute eased alpha and apply to all properties
			local alpha = elapsed * inverseDirection
			local easedAlpha
			if reversing then
				easedAlpha = math.clamp(easingFunction(1 - alpha), 0, 1)
			else
				easedAlpha = math.clamp(easingFunction(alpha), 0, 1)
			end

			for i = 1, propertyCount do
				instance[propertyNames[i]] = propertyLerps[i](easedAlpha)
			end
		end)

		tween.PlaybackState = Enum.PlaybackState.Playing
		trove:Add(stepConnection)
	end

	function tween:Play()
		elapsed = 0
		playLayer(1, false)
	end

	function tween:Stop()
		if stepConnection then
			stepConnection:Disconnect()
			stepConnection = nil
			tween.PlaybackState = Enum.PlaybackState.Cancelled
			onStopped:Fire()
		end
	end

	function tween:Resume()
		playLayer(currentLayer, isReversing)
		onResumed:Fire()
	end

	return tween
end

return BoatTween