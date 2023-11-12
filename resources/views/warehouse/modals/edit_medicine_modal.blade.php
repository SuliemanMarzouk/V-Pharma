<!-- edit_modal.blade.php -->
<div class="modal fade" id="editMedicineModal-{{ $medicine->ID }}" tabindex="-1" role="dialog" aria-labelledby="editMedicineModalLabel-{{ $medicine->ID }}" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editMedicineModalLabel">Edit Medicine</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="editMedicineForm" action="{{ route('medicines.update', $medicine->ID) }}" method="POST">
                @csrf
                @method('PUT')
                <div class="modal-body">
                    <div class="form-group">
                        <label for="medicineName">Medicine Name</label>
                        <input type="text" class="form-control" id="medicineName" name="medicineName" value="{{ $medicine->MedicineName }}" required>
                    </div>
                    <div class="form-group">
                        <label for="medicineDetails">Medicine Details</label>
                        <textarea class="form-control" id="medicineDetails" name="medicineDetails" rows="3" required>{{ $medicine->MedicineDetails }}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="productionDate">Production Date</label>
                        <input type="date" class="form-control" id="productionDate" name="productionDate" value="{{ $medicine->ProductionDate }}" required>
                    </div>
                    <div class="form-group">
                        <label for="expireDate">Expire Date</label>
                        <input type="date" class="form-control" id="expireDate" name="expireDate" value="{{ $medicine->ExpireDate }}" required>
                    </div>
                    <div class="form-group">
                        <label for="quantity">Quantity</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" value="{{ $medicine->warehouses()->first()->pivot->Quantity }}" required>
                    </div>
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input type="number" step="0.01" class="form-control" id="price" name="price" value="{{ $medicine->warehouses()->first()->pivot->Price }}" required>
                    </div>
                    <div class="form-group">
                        <label for="prescription_required">Prescription Required</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="prescription_required" name="prescription_required" value="1" {{ $medicine->prescription_required ? 'checked' : '' }}>
                            <label class="form-check-label" for="prescription_required">
                                Requires Prescription
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>