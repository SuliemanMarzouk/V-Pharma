<!-- add_medicine_modal.blade.php -->
<div class="modal fade" id="addMedicineModal" tabindex="-1" aria-labelledby="addMedicineModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addMedicineModalLabel">Add Medicine</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
            <form action="/pharma/store-medicine" method="POST">
    @csrf <!-- Place the @csrf directive here -->
                
                <div class="form-group">
                    <label for="medicineName">Medicine Name</label>
                    <input type="text" class="form-control" id="medicineName" name="medicineName" placeholder="Enter medicine name" required>
                </div>
                <div class="form-group">
                    <label for="medicineDetails">Medicine Details</label>
                    <textarea class="form-control" id="medicineDetails" name="medicineDetails" rows="3" placeholder="Enter medicine details" required></textarea>
                </div>
                <div class="form-group">
                    <label for="productionDate">Production Date</label>
                    <input type="date" class="form-control" id="productionDate" name="productionDate" placeholder="Enter production date" required>
                </div>
                <div class="form-group">
                    <label for="expireDate">Expire Date</label>
                    <input type="date" class="form-control" id="expireDate" name="expireDate" placeholder="Enter expiry date" required>
                </div>
                <div class="form-group">
                    <label for="quantity">Quantity</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" placeholder="Enter quantity" required>
                </div>
                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="number" step="0.01" class="form-control" id="price" name="price" placeholder="Enter price" required>
                </div>
                @if(isset($medicine))
                <div class="form-group">
                    <label for="prescription_required">Prescription Required</label>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="prescription_required" name="prescription_required" value="1" {{ $medicine->prescription_required ? 'checked' : '' }}>
                        <label class="form-check-label" for="prescription_required">
                            Requires Prescription
                        </label>
                    </div>
                </div>
                @endif
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" id="saveMedicineBtn">Save</button>
                </div>
            </form>
            </div>
        </div>
    </div>
</div>