<!-- Modal -->
@if(isset($pharmacyOrder))
<div class="modal fade" id="deliveryModal{{ $pharmacyOrder->ID }}" tabindex="-1" role="dialog" aria-labelledby="deliveryModalLabel{{ $pharmacyOrder->ID }}" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deliveryModalLabel">Select Delivery</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Delivery selection form here -->
                <form id="deliveryForm{{ $pharmacyOrder->ID }}" action="{{ route('updateDeliveryPhOrder', ['pharmacyOrderId' => $pharmacyOrder->ID]) }}" method="POST">
                    @csrf
                    <select name="deliveryId" class="form-control">
                        @foreach ($deliveries as $delivery)
                            <option value="{{ $delivery->ID }}">{{ $delivery->FullName }}</option>
                         @endforeach
                    </select>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" form="deliveryForm{{ $pharmacyOrder->ID }}" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
@endif

<!-- Modal customer -->
@if(isset($customerOrder))
<div class="modal fade" id="deliveryCustomerModal{{ $customerOrder->ID }}" tabindex="-1" role="dialog" aria-labelledby="deliverycustomerModalLabel{{ $customerOrder->ID }}" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deliverycustomerModalLabel">Select Delivery</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Delivery selection form here -->
                <form id="deliveryCustomerForm{{ $customerOrder->ID }}" action="{{ route('updateDeliveryCusOrder', ['customerOrderId' => $customerOrder->ID]) }}" method="POST">
                    @csrf
                    <select name="deliveryId" class="form-control">
                        @foreach ($deliveries as $delivery)
                            <option value="{{ $delivery->ID }}">{{ $delivery->FullName }}</option>
                         @endforeach
                    </select>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" form="deliveryCustomerForm{{ $customerOrder->ID }}" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
@endif