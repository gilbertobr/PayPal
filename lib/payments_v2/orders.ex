defmodule PayPal.PaymentsV2.Orders do
  @moduledoc """
  Documentation for PayPal.Payments.Orders

  https://developer.paypal.com/docs/api/payments/#order
  """

  @doc """
  Create order

  [docs](https://developer.paypal.com/docs/api/orders/v2/#orders_create)

  This can be a bit prickly so I highly suggest you check out the official docs (above), this maps 1:1 to the HTTP API.

  Possible returns:

  - {:ok, payment}
  - {:error, reason}

  ## Examples

    iex> PayPal.PaymentsV2.Payments.create(%{
  "intent": "CAPTURE",
  "purchase_units": [
    %{
      "reference_id": "d9f80740-38f0-11e8-b467-0ed5f89f718b",
      "amount": %{
        "currency_code": "USD",
        "value": "100.00"
      }
    }
  ],
  "payment_source": %{
    "paypal": %{
      "experience_context": %{
        "payment_method_preference": "IMMEDIATE_PAYMENT_REQUIRED",
        "payment_method_selected": "PAYPAL",
        "brand_name": "EXAMPLE INC",
        "locale": "en-US",
        "landing_page": "LOGIN",
        "shipping_preference": "SET_PROVIDED_ADDRESS",
        "user_action": "PAY_NOW",
        "return_url": "https://example.com/returnUrl",
        "cancel_url": "https://example.com/cancelUrl"
      }
    }
  }
})
    {:ok, %{
  "id": "5O190127TN364715T",
  "status": "PAYER_ACTION_REQUIRED",
  "payment_source": %{
    "paypal": %{}
  },
  "links": [
    %{
      "href": "https://api-m.paypal.com/v2/checkout/orders/5O190127TN364715T",
      "rel": "self",
      "method": "GET"
    },
    %{
      "href": "https://www.paypal.com/checkoutnow?token=5O190127TN364715T",
      "rel": "payer-action",
      "method": "GET"
    }
  ]
}}

  """  
  @spec create(map) :: {:ok, map | :not_found | :no_content | nil} | {:error, :unauthorised | :bad_network | any}
  def create(order) do
    PayPal.API.post("v2/checkout/orders", order)
  end

  @doc """
  Show an order

  [docs](https://developer.paypal.com/docs/api/orders/v2/#orders_get)

  Possible returns:

  - {:ok, order}
  - {:error, reason}

  ## Examples

    iex> PayPal.Payments.Orders.show(order_id)
    {:ok, order}
  """
  @spec show(String.t) :: {:ok, map | :not_found | :no_content } | {:error, :unauthorised | :bad_network | any}
  def show(order_id) do
    PayPal.API.get("v2/checkout/orders/#{order_id}")
  end

  @doc """
  Authorize an order

  [docs](https://developer.paypal.com/docs/api/orders/v2/#orders_authorize)

  Possible returns:

  - {:ok, refund}
  - {:error, refund}

  ## Examples

    iex> PayPal.Payments.Orders.authorize(order_id, %{
      amount: %{
        total: "1.50",
        currency: "USD"
      }
    })
    {:ok, refund}
  """
  @spec authorize(String.t, map) :: {:ok, map | :not_found | :no_content | nil} | {:error, :unauthorised | :bad_network | any}
  def authorize(payment_id, params) do
    PayPal.API.post("v2/checkout/orders/#{payment_id}/authorize", params)
  end

  @doc """
  Capture an order

  [docs](https://developer.paypal.com/docs/api/orders/v2/#orders_capture)

  Possible returns:

  - {:ok, capture}
  - {:error, refund}

  ## Examples

    iex> PayPal.Payments.Orders.capture(order_id, %{
      amount: %{
        total: "1.50",
        currency: "USD"
      },
      is_final_capture: true
    })
    {:ok, capture}
  """
  @spec capture(String.t, map) :: {:ok, map | :not_found | :no_content} | {:error, :unauthorised | :bad_network | any}
  def capture(order_id, params) do
    PayPal.API.post("v2/checkout/orders/#{order_id}/capture", params)
  end

end
