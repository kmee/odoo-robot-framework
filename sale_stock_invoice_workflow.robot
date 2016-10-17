*** Settings ***

Documentation  Full workflow demonstration
Resource       odoo_8_0.robot

*** Test Cases ***
Valid Login
	Login

Create Sale Order
	MainMenu   Sales
	SubMenu    Sales Orders
	Button    sale.order    oe_list_add
	Many2OneSelect    sale.order    partner_id	Agrolait, Thomas Passot
	Date		sale.order	date_order	08/30/2015
	Char		sale.order	client_order_ref	AGR001
    Capture Page Screenshot
	NewOne2Many    sale.order    order_line
	Many2OneSelect    sale.order.line    product_id	[HDD-SH2] HDD SH-2
	Char    sale.order.line    product_uom_qty    2
	Button	sale.order.line	   oe_form_button_save_and_close
	NotebookPage    Other Information
	Select-Option    sale.order	picking_policy	Deliver all products at once
	Select-Option    sale.order	order_policy	On Delivery Order
    Capture Page Screenshot
	Button	sale.order	   oe_form_button_save
	Capture Page Screenshot

Process Sale Order
	Button    sale.order    action_button_confirm
	Button    sale.order    action_view_delivery
    Capture Page Screenshot
Process Delivery Order
	Button    stock.picking    action_assign
	Button    stock.picking    do_enter_transfer_details
    Capture Page Screenshot
	Button    stock.transfer_details    do_detailed_transfer
    Capture Page Screenshot
Invoice Delivery Order
	Button	  stock.picking    403
	Button	  stock.invoice.onshipping	open_invoice
    Capture Page Screenshot
    SelectListView      account.invoice      partner_id=Agrolait, Thomas Passot
    Capture Page Screenshot
    Button    account.invoice       invoice_open
    Capture Page Screenshot
    Button    account.invoice       invoice_print
    Capture Page Screenshot

