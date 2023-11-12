<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Pharmacy Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="{{ asset('admin/vendor/fontawesome-free/css/all.min.css') }}" rel="stylesheet">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="{{ asset('admin/css/sb-admin-2.css') }}" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
        @include('pharmacy/navbar')

        <!-- Begin Page Content -->
        <div class="container-fluid">
            <!-- Page Heading -->
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <h1 class="h3 mb-0 text-gray-800">List Warehouse</h1>
                <!-- <button class="btn btn-primary" id="addToCartButton">Add to Cart</button> -->
            </div>

            <br><br>

            <div class="container">
            <h1>Medicines in Warehouse</h1>
                <form id="addToCartForm" method="POST" action="{{ route('pharmacy_orders.store', $warehouse->ID) }}">
                    @csrf
                    <div class="row">
                        @foreach ($warehouse->medicines as $medicine)
                        <div class="col-md-4 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">{{ $medicine->MedicineName }}</h5>
                                    <p class="card-text">Price: {{ $medicine->pivot->Price }}</p>
                                    <p class="card-text">Details: {{ $medicine->MedicineDetails }}</p>
                                    <div class="form-group">
                                        <label for="quantity{{ $medicine->ID }}" class="mr-2">Quantity:</label>
                                        <div class="input-group" style="width: 60px;">
                                            <input type="number" class="form-control" name="quantity[{{ $medicine->ID }}]" value="0" min="0">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        @endforeach
                    </div>
                    <button type="button" class="btn btn-primary" id="openOrderDetailsModal" data-toggle="modal" data-target="#orderDetailsModal">
                        Place Order
                    </button>
                </form>
            </div>
        </div>
    </div>
    @include('admin/footer')

    <!-- Order Details Modal -->
    <div class="modal fade" id="orderDetailsModal" tabindex="-1" role="dialog" aria-labelledby="orderDetailsModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orderDetailsModalLabel">Order Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table" id="orderDetailsTable">
                        <thead>
                            <tr>
                                <th>Medicine</th>
                                <th>Price</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Populate the order details dynamically -->
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="submit" form="addToCartForm" class="btn btn-primary">Confirm Order</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->

    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="{{ asset('admin/vendor/jquery/jquery.min.js') }}"></script>
    <script src="{{ asset('admin/vendor/bootstrap/js/bootstrap.bundle.min.js') }}"></script>

    <!-- Core plugin JavaScript-->
    <script src="{{ asset('admin/vendor/jquery-easing/jquery.easing.min.js') }}"></script>

    <!-- Custom scripts for all pages-->
    <script src="{{ asset('admin/js/sb-admin-2.min.js') }}"></script>

    <!-- Page level plugins -->
    <script src="{{ asset('admin/vendor/chart.js/Chart.min.js') }}"></script>

    <!-- Page level custom scripts -->
    <script src="{{ asset('admin/js/demo/chart-area-demo.js') }}"></script>
    <script src="{{ asset('admin/js/demo/chart-pie-demo.js') }}"></script>


    <script>
        $(document).ready(function () {
        // Function to check if all quantities are <= 0
        function areAllQuantitiesZero() {
            var allQuantitiesZero = true;
            $('input[name^="quantity"]').each(function () {
            var quantity = parseInt($(this).val());
            if (quantity > 0) {
                allQuantitiesZero = false;
                return false; // Exit the loop early
            }
            });
            return allQuantitiesZero;
        }

        // Disable the "Place Order" button initially if all quantities are <= 0
        if (areAllQuantitiesZero()) {
            $('#openOrderDetailsModal').prop('disabled', true);
        }

        // Update the "Place Order" button whenever the quantity changes
        $('input[name^="quantity"]').on('input', function () {
            if (areAllQuantitiesZero()) {
            $('#openOrderDetailsModal').prop('disabled', true);
            } else {
            $('#openOrderDetailsModal').prop('disabled', false);
            }
        });

        // Open the order details modal when the "Place Order" button is clicked
        $('#openOrderDetailsModal').click(function () {
            // Code to populate the order details table goes here
        });
        });
        $(document).ready(function () {
        // Function to populate the order details table
        function populateOrderDetails() {
            var orderDetailsTable = $('#orderDetailsTable tbody');
            orderDetailsTable.empty();

            var deliveryCost = 8000; // Set the delivery cost

            // Iterate through the medicines and add rows to the table
            @foreach ($warehouse->medicines as $medicine)
            var quantityInput = $('input[name="quantity[{{ $medicine->ID }}]"]');
            var quantity = parseInt(quantityInput.val());
            if (quantity > 0) {
                var price = parseInt('{{ $medicine->pivot->Price }}');
                var row = $('<tr></tr>');
                row.append($('<td></td>').text('{{ $medicine->MedicineName }}'));
                row.append($('<td></td>').text(price));
                row.append($('<td></td>').text(quantity));
                orderDetailsTable.append(row);
            }
            @endforeach

            // Add the delivery cost row
            var deliveryCostRow = $('<tr></tr>');
            deliveryCostRow.append($('<td></td>').text('Delivery Cost'));
            deliveryCostRow.append($('<td></td>').text(deliveryCost));
            deliveryCostRow.append($('<td></td>'));
            orderDetailsTable.append(deliveryCostRow);

            // Calculate the total
            var total = deliveryCost;
            orderDetailsTable.find('tr').each(function () {
            var price = parseInt($(this).find('td:nth-child(2)').text());
            var quantity = parseInt($(this).find('td:nth-child(3)').text());
            if (!isNaN(price) && !isNaN(quantity)) {
                total += price * quantity;
            }
            });

            // Add the total row
            var totalRow = $('<tr></tr>');
            totalRow.append($('<td></td>').text('Total'));
            totalRow.append($('<td></td>').text(total));
            totalRow.append($('<td></td>'));
            orderDetailsTable.append(totalRow);
        }

        // Update the order details table whenever the quantity changes
        $('input[name^="quantity"]').on('input', function () {
            populateOrderDetails();
        });

        // Open the order details modal when the "Place Order" button is clicked
        $('#openOrderDetailsModal').click(function () {
            populateOrderDetails();
            $('#orderDetailsModal').modal('show');
        });
        });
    </script>

</body>