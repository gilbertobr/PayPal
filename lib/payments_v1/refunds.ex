defmodule PayPal.PaymentsV1.Refunds do
  @moduledoc """
  Documentation for PayPal.PaymentsV1.Refunds

  https://developer.paypal.com/docs/api/payments/#refund
  """

  @doc """
  Show a refund

  [docs](https://developer.paypal.com/docs/api/payments/#refund_get)

  Possible returns:

  - {:ok, refund}
  - {:error, reason}

  ## Examples

    iex> PayPal.PaymentsV1.Refunds.show(refund_id)
    {:ok, refund}
  """
  @spec show(String.t) :: {:ok, map | :not_found | :no_content } | {:error, :unauthorised | :bad_network | any}
  def show(refund_id) do
    PayPal.API.get("payments/refund/#{refund_id}")
  end

end
