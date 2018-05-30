class SalePdf < Prawn::Document
	def initialize(sale, account)
		super(top_margin: 50)
		@sale = sale
		@account = account
		biz_info
		sale_code
		sale_name
		teller
		date
		time
		sale_items
		total_price
		balance		
	end

	def sale_code
		move_down 20
		text "Sale \##{@sale.code}", size: 20, style: :bold
	end

	def sale_name
		move_down 20
		text "Customer: #{@sale.name}", size: 20, style: :bold
	end

	def teller
		move_down 20
		text "Served by: #{@sale.user.name}", size: 20, style: :bold
	end

	def date
		move_down 20
		text "Date: #{@sale.created_at.strftime('%d %b %Y')}", size: 20, style: :bold
	end

	def time
		move_down 20
		text "Time: #{@sale.created_at.strftime('%T')}", size: 20, style: :bold
	end

	def total_price
		move_down 20
		text "Total: #{@sale.total_price}", size: 20, style: :bold
	end

	def balance
		move_down 20
		text "Balance: #{@sale.balance}", size: 20, style: :bold
	end

	def sale_items
		move_down 20
		table sale_item_rows do
			row(0).font_style = :bold
			columns(1..3).align = :right
			self.row_colors = ['DDDDDD', 'FFFFFF']
			self.header = true
		end
	end

	def sale_item_rows
		[["Product", "Qty", "Unit Price", "Total Price"]] +
		@sale.sale_items.map do |item|
			[item.product.name, item.quantity, item.product.selling_price, item.total_price]
		end
	end

	def biz_info
		text "#{@account.name } #{@account.business_type}", size: 10, align: :center, style: :italic
	end
end