<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin Dashboard</title>

    <!-- Custom fonts for this template -->
    <link href="{{ asset('admin/vendor/fontawesome-free/css/all.min.css') }}" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="{{ asset('admin/css/sb-admin-2.css') }}" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
    @include('warehouse/navbar')

    <!-- Begin Page Content -->
    <div class="container">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-md-8">
                            <h4>List Of Medicine</h4>
                        </div>
                        <div class="col-md-4 text-right">
                            <a href="#" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#addMedicineModal">Add Medicine</a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                    <th>Name Medicine</th>
                                    <th>Details Medicine</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Production Date</th>
                                    <th>Expiry Date</th>
                                    <th>Options</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($medicines as $medicine)
                                    <tr>
                                        <td>{{ $medicine->MedicineName }}</td>
                                        <td>{{ $medicine->MedicineDetails }}</td>
                                        <td>
                                            @foreach ($medicine->warehouses as $warehouse)
                                                @if ($warehouse->user_id === Auth::user()->id)
                                                    {{ $warehouse->pivot->Quantity }}
                                                @endif
                                            @endforeach
                                        </td>
                                        <td>
                                            @foreach ($medicine->warehouses as $warehouse)
                                                @if ($warehouse->user_id === Auth::user()->id)
                                                    {{ $warehouse->pivot->Price }}
                                                @endif
                                            @endforeach
                                        </td>
                                        <td>{{ $medicine->ProductionDate }}</td>
                                        <td>{{ $medicine->ExpireDate }}</td>
                                        <td>
                                        <div class="d-flex justify-content-center">
                                            <button type="button" class="btn btn-primary btn-sm mr-2 custom-btn" data-toggle="modal" data-target="#editMedicineModal-{{ $medicine->ID }}">
                                                <i class="fas fa-edit"></i>Edit
                                            </button>
                                            <a href="{{ route('medicines.destroy', $medicine->ID) }}"
                                                class="btn btn-danger btn-sm"
                                                onclick="event.preventDefault();
                                                            if (confirm('Are you sure you want to delete this record?')) {
                                                                document.getElementById('delete-form-{{ $medicine->ID }}').submit();
                                                            }">
                                                    <i class="fas fa-trash-alt"></i> Delete
                                            </a>

                                            <form id="delete-form-{{ $medicine->ID }}"
                                                action="{{ route('medicines.destroy', $medicine->ID) }}"
                                                method="POST"
                                                style="display: none;">
                                                @csrf
                                                @method('DELETE')
                                            </form>
                                        </div>
                                        </td>
                                    </tr>
                                        <!-- Edit modal -->
                                        @include('warehouse/modals/edit_medicine_modal', ['medicine' => $medicine])
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
        @include('admin/footer')
        <!-- Include the add_medicine_modal.blade.php file -->
        @include('warehouse/modals/add_medicine_modal')
</div>
</div>
</div>

    <!-- Scroll to Top Button -->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript -->
    <script src="{{ asset('admin/vendor/jquery/jquery.min.js') }}"></script>
    <script src="{{ asset('admin/vendor/bootstrap/js/bootstrap.bundle.min.js') }}"></script>

    <!-- Core plugin JavaScript -->
    <script src="{{ asset('admin/vendor/jquery-easing/jquery.easing.min.js') }}"></script>

    <!-- Custom scripts for all pages -->
    <script src="{{ asset('admin/js/sb-admin-2.min.js') }}"></script>

    <!-- Page level plugins -->
    <script src="{{ asset('admin/vendor/chart.js/Chart.min.js') }}"></script>

    <!-- Page level custom scripts -->
    <script src="{{ asset('admin/js/demo/chart-area-demo.js') }}"></script>
    <script src="{{ asset('admin/js/demo/chart-pie-demo.js') }}"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>