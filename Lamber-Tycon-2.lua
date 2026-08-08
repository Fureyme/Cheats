--loadstring(game:HttpGet("https://raw.githubusercontent.com/Fureyme/Cheats/refs/heads/main/Lamber-Tycon-2.lua"))()
local localPlayer = game:GetService("Players").LocalPlayer
local playerPos = localPlayer.Character.HumanoidRootPart
local Event = game:GetService("ReplicatedStorage").Interaction.RemoteProxy
local treeChoped = game:GetService("ReplicatedStorage"):WaitForChild("Notices"):WaitForChild("ShowUserInstructionRemote")

local firstPlayerPos = playerPos.CFrame
local isListening = true -- Управляйте этим флагом из любой части кода
local treesCounter = 0
local treeChoping = false

--Settings
local allSwitch = false
local treeType = "Birch"
local treeFallType = "Loose_Birch"
local treeAmount = 1

for indexRegion, region in pairs(workspace:GetChildren()) do --Пошук регіонів з деревами
	if region.Name == "TreeRegion" and region.ClassName == "Model" then
		for indexTree, tree in pairs(workspace:GetChildren()[indexRegion]:GetChildren()) do --Пошук типа дерева
			if tree.TreeClass and tree.TreeClass.Value == treeType then 
				for indexLog, log in pairs(workspace:GetChildren()[indexRegion]:GetChildren()[indexTree]:GetChildren()) do
					if log.Name == "WoodSection" and log.ID.Value == 1 then

						print(indexLog)
						print(log.Size.Y)
						print(log.CFrame)
						print("workspace:GetChildren()[" .. indexRegion .. "]:GetChildren()[" .. indexTree .. "].CutEvent")
						
						playerPos.CFrame = log.CFrame
						treeChoping = true

						while treeChoping do 
							--Ивент для рубки дерерва
							Event:FireServer(
								workspace:GetChildren()[indexRegion]:GetChildren()[indexTree].CutEvent,
								{
									height = 1, --высота рубки
									faceVector = Vector3.new(-1, 0, 0),
									--localPlayer.Character.Tool
									tool = game:GetService("Players").LocalPlayer.Backpack.Tool,
									sectionId = 1, --низ дерерва
									hitPoints = 0.2,
									cooldown = 0.65,
									cuttingClass = "Axe"
								})
							wait(0.5)

							treeChoped.OnClientEvent:Connect(function(...)

								if not isListening then 
									return -- Игнорируем вызов, если условие isListening == false
								end

								treeChoping = false
							end)
						end
						-- Дерево зрублено
						treesCounter = treesCounter + 1

						for index, fallTree in pairs(workspace.LogModels:GetChildren()) do -- Пошук зрубленого дерерва
							if fallTree.Name == treeFallType and fallTree.Owner.Value == localPlayer.Name then
								
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
								BodyGyro.MaxTorque = Vector3.new(200, 200, 200)
								BodyGyro.P = 30000

								-- Додаємо BodyPosition для керування фізикою
								local BodyPos = Instance.new("BodyPosition", Dragger)
								BodyPos.MaxForce = Vector3.new(1000000, 1000000, 1000000)
								BodyPos.P = 10000
								BodyPos.D = 800
								BodyPos.Position = Part.Position

								-- Приварюємо дерево до Dragger
								local Weld = Instance.new("Weld", Dragger)
								Weld.Name = "DraggerWeld"
								Weld.Part0 = Dragger
								Weld.Part1 = Part
								Weld.C0 = CFrame.new()
								Weld.C1 = Dragger.CFrame:ToObjectSpace(Part.CFrame)

								-- 4. Запускаем фоновий потік підтримки з'єднання з сервером
								local Dragging = true
								task.spawn(function()
									local Event = game:GetService("ReplicatedStorage").Interaction.ClientIsDragging
									while Dragging do
										Event:FireServer(TargetLog)
										task.wait(0.1)
									end
								end)

								Dragger.CFrame = firstPlayerPos
								workspace.LogModels.Loose_Birch.WoodSection.CFrame = firstPlayerPos
								BodyPos.Position = firstPlayerPos.Position
								BodyGyro.CFrame = firstPlayerPos
								playerPos.CFrame = firstPlayerPos

								Dragger:Destroy()
								Dragging = false
							end
						end

					elseif treesCounter >= treeAmount and allSwitch == false then
						isListening = false
						return --break для всіх for
					end
				end
			end
		end
	end
end
