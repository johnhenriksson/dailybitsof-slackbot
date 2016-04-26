class Dailybitsof

	def self.categories
		response = HTTParty.get('https://dailybitsof.com/api/categories')
		data = JSON.parse(response.body)

		return data
	end

	def self.courses(category, limit)
        response = HTTParty.get("https://dailybitsof.com/api/courses?category=#{category}&limit=#{limit}")
        data = JSON.parse(response.body)

		return data
	end

end