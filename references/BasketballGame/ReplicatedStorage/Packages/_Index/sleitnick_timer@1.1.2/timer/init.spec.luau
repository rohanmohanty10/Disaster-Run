 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
return function()
	local Timer = require(script.Parent)

	describe("Timer", function()
		local timer

		beforeEach(function()
			timer = Timer.new(0.1)
			timer.TimeFunction = os.clock
		end)

		afterEach(function()
			if timer then
				timer:Destroy()
				timer = nil
			end
		end)

		it("should create a new timer", function()
			expect(Timer.Is(timer)).to.equal(true)
		end)

		it("should tick appropriately", function()
			local start = os.clock()
			timer:Start()
			timer.Tick:Wait()
			local duration = (os.clock() - start)
			expect(duration).to.be.near(duration, 0.02)
		end)

		it("should start immediately", function()
			local start = os.clock()
			local stop = nil
			timer.Tick:Connect(function()
				if not stop then
					stop = os.clock()
				end
			end)
			timer:StartNow()
			timer.Tick:Wait()
			expect(stop).to.be.a("number")
			local duration = (stop - start)
			expect(duration).to.be.near(0, 0.02)
		end)

		it("should stop", function()
			local ticks = 0
			timer.Tick:Connect(function()
				ticks += 1
			end)
			timer:StartNow()
			timer:Stop()
			task.wait(1)
			expect(ticks).to.equal(1)
		end)

		it("should detect if running", function()
			expect(timer:IsRunning()).to.equal(false)
			timer:Start()
			expect(timer:IsRunning()).to.equal(true)
			timer:Stop()
			expect(timer:IsRunning()).to.equal(false)
			timer:StartNow()
			expect(timer:IsRunning()).to.equal(true)
			timer:Stop()
			expect(timer:IsRunning()).to.equal(false)
		end)
	end)
end

]]

 

return function() -- Line: 1
    local script_Parent = require(script.Parent);
    describe("Timer", function() -- Line: 4
        -- upvalues: script_Parent (copy)
        local u1 = nil;
        beforeEach(function() -- Line: 7
            -- upvalues: u1 (ref), script_Parent (ref)
            u1 = script_Parent.new(0.1);
            u1.TimeFunction = os.clock;
        end);
        afterEach(function() -- Line: 12
            -- upvalues: u1 (ref)
            if u1 then
                u1:Destroy();
                u1 = nil;
            end;
        end);
        it("should create a new timer", function() -- Line: 19
            -- upvalues: script_Parent (ref), u1 (ref)
            expect(script_Parent.Is(u1)).to.equal(true);
        end);
        it("should tick appropriately", function() -- Line: 23
            -- upvalues: u1 (ref)
            local os_clock_ret = os.clock();
            u1:Start();
            u1.Tick:Wait();
            local v2 = os.clock() - os_clock_ret;
            expect(v2).to.be.near(v2, 0.02);
        end);
        it("should start immediately", function() -- Line: 31
            -- upvalues: u1 (ref)
            local os_clock_ret = os.clock();
            local u3 = nil;
            u1.Tick:Connect(function() -- Line: 34
                -- upvalues: u3 (ref)
                if not u3 then
                    u3 = os.clock();
                end;
            end);
            u1:StartNow();
            u1.Tick:Wait();
            expect(u3).to.be.a("number");
            expect(u3 - os_clock_ret).to.be.near(0, 0.02);
        end);
        it("should stop", function() -- Line: 46
            -- upvalues: u1 (ref)
            local u4 = 0;
            u1.Tick:Connect(function() -- Line: 48
                -- upvalues: u4 (ref)
                u4 = u4 + 1;
            end);
            u1:StartNow();
            u1:Stop();
            task.wait(1);
            expect(u4).to.equal(1);
        end);
        it("should detect if running", function() -- Line: 57
            -- upvalues: u1 (ref)
            expect(u1:IsRunning()).to.equal(false);
            u1:Start();
            expect(u1:IsRunning()).to.equal(true);
            u1:Stop();
            expect(u1:IsRunning()).to.equal(false);
            u1:StartNow();
            expect(u1:IsRunning()).to.equal(true);
            u1:Stop();
            expect(u1:IsRunning()).to.equal(false);
        end);
    end);
end;