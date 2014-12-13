function love.load()
	IMAGE_background = love.graphics.newImage("grass.jpg")
	IMAGE_coin = love.graphics.newImage("coins.png")
	FONT_score = love.graphics.newFont("font.ttf", 20)

	coins = {}

	score = 0
	CoinsLive = 3
	SpawnInterval = 1.5
end

function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(IMAGE_background, 0, 0)

	for i = 1, #coins do
		love.graphics.draw(IMAGE_coin, coins[i].x, coins[i].y)
	end

	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), 50)
	love.graphics.setColor(100, 50,50)
	love.graphics.setFont(FONT_score)
	love.graphics.print("Your score: "..score, 10, 10)
end

delay = 0
function love.update(dt)
	delay = delay + dt

	if delay > SpawnInterval then
		delay = 0

		table.insert(coins, {
			x = love.math.random( 50, love.window.getWidth() ),
			y = love.math.random( 50, love.window.getHeight() ),
			created = love.timer.getTime()
		})
	end

	local removable = {}
	for i = 1, #coins do
		if love.timer.getTime() - coins[i].created > CoinsLive then
			table.insert(removable, i)
		end
	end 
	for i = 1, #removable do
		table.remove(coins, removable[i])
	end
end

function love.keypressed(key)

	if key=="escape" then
		love.event.quit()
	end
end

function love.mousepressed(x, y, button)

	if button == "l" then

		for i = 1, #coins do
			local cx = coins[i].x
			local cy = coins[i].y
			if distance(x, y, cx+10, cy+10) < 20 then
				score = score + 1
				table.remove(coins, i)

				if (score % 10==0) then
					CoinsLive = CoinsLive - 0.1
				end
				break
			end
		end

	end

end

function distance(x1, y1, x2, y2)
	return math.sqrt( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) )
end