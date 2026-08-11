--loadstring(game:HttpGet("https://raw.githubusercontent.com/Fureyme/Cheats/refs/heads/main/Lamber-Tycon-2.lua"))()
local localPlayer = game:GetService("Players").LocalPlayer
local playerPos = localPlayer.Character.HumanoidRootPart
local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy
local treeChoped = game:GetService("ReplicatedStorage"):WaitForChild("Notices"):WaitForChild("ShowUserInstructionRemote")

local firstPlayerPos = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position)
local isListening = true
local treesCounter = 0
local treeChoping = false                                    ---добав щоб скрипт вибирав найкращий топорик
local fallTree
local logCount = -3
local log

--Settings
local allSwitch = false
local treeType = "Birch"
local treeFallType = "Loose_Birch"
local treeAmount = 3

for indexRegion, region in pairs(workspace:GetChildren()) do --Пошук регіонів з деревами
	if region.Name == "TreeRegion" and region.ClassName == "Model" then
		for indexTree, tree in pairs(workspace:GetChildren()[indexRegion]:GetChildren()) do --Пошук типа дерева
			if tree:FindFirstChild("TreeClass") and tree.TreeClass.Value == treeType then
				for indexLog, WoodSection in pairs(workspace:GetChildren()[indexRegion]:GetChildren()[indexTree]:GetChildren()) do
					if WoodSection.Name == "WoodSection" then
						logCount = logCount + 1
					end
				end

				if logCount <= 0 then
					logCount = -3
					continue
				end

				for indexLog, log in pairs(workspace:GetChildren()[indexRegion]:GetChildren()[indexTree]:GetChildren()) do
					if log.Name == "WoodSection" and log.ID.Value == 1 then
						logCount = -3
						playerPos.CFrame = log.CFrame --добав переміщеня від дерерва на 2-3 студа

						local connection
						connection = workspace.LogModels.ChildAdded:Connect(function(child)
							if child.Name == treeFallType and child:WaitForChild("Owner"):WaitForChild("OwnerString"):WaitForChild("Value") == localPlayer.Name then
								fallTree = child
								treeChoping = false
							end
						end)

						
						--local connectionChoped
						--connectionChoped = treeChoped.OnClientEvent:Connect(function(instruction)
						
						--end)

						treeChoping = true
						while treeChoping do 
							--Ивент для рубки дерерва
							Event:FireServer(
								workspace:GetChildren()[indexRegion]:GetChildren()[indexTree].CutEvent,
								{
									height = 0.30, --высота рубки(0.30 мин значения)
									faceVector = Vector3.new(-1, 0, 0),
									tool = game:GetService("Players").LocalPlayer.Backpack.Tool,
									sectionId = 1, --низ дерерва
									hitPoints = 1.45, --Hardened Axe
									cooldown = 0.1,
									cuttingClass = "Axe"
								})
							wait(0.05)
						end

						--if connectionChoped then connectionChoped:Disconnect() end -- Отключаем слушатель после завершения рубки

						connection:Disconnect() -- Відключаємо відстеження

						-- Дерево зрублено
						treesCounter = treesCounter + 1
						
						local Part = fallTree.WoodSection

						-- Створюємо локальний Dragger (як v_u_12 у коді гри)
						local Dragger = Instance.new("Part")
						Dragger.Size = Vector3.new(1, 1, 1)
						Dragger.Transparency = 1
						Dragger.CanCollide = false
						Dragger.CFrame = Part.CFrame
						Dragger.Parent = workspace

						local BodyGyro = Instance.new("BodyGyro", Dragger)
						BodyGyro.CFrame = Part.CFrame
						BodyGyro.D = 140
						BodyGyro.MaxTorque = Vector3.new(5000, 5000, 5000)
						BodyGyro.P = 30000
		
						-- Додаємо BodyPosition для керування фізикою
						local BodyPos = Instance.new("BodyPosition", Dragger)
						BodyPos.MaxForce = Vector3.new(1000000, 1000000, 1000000)
						BodyPos.P = 10000
						BodyPos.D = 800
						BodyPos.Position = Part.Position

						-- Приварюємо дерево до Dragger
						local Weld = Instance.new("Weld", Dragger)
						Weld.Part0 = Dragger
						Weld.Part1 = Part
						Weld.C0 = CFrame.new()
						Weld.C1 = Dragger.CFrame:ToObjectSpace(Part.CFrame)

						-- Запускаем фоновий потік підтримки з'єднання з сервером
						local Dragging = true
						task.spawn(function()
							local Event = game:GetService("ReplicatedStorage").Interaction.ClientIsDragging
							while Dragging do
								Event:FireServer(fallTree)
								task.wait(0.05)
							end
						end)
						wait(0.1)

						Dragger.CFrame = firstPlayerPos
						fallTree.WoodSection.CFrame = firstPlayerPos
						BodyPos.Position = firstPlayerPos.Position
						BodyGyro.CFrame = firstPlayerPos
						playerPos.CFrame = firstPlayerPos

						Dragger:Destroy()
						Dragging = false
					end

					if treesCounter >= treeAmount and allSwitch == false then
						isListening = false
						return --break для всіх for
					end
				end
			end
		end
	end
end
