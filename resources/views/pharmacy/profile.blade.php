<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="{{ asset('admin/vendor/fontawesome-free/css/all.min.css') }}" rel="stylesheet" type="text/css">
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
                <h1 class="h3 mb-0 text-gray-800">Profile</h1>
            </div>

            <br><br>
            <div class="container">
                <h1>Pharmacy Profile</h1>

                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title">Pharmacy Details</h3>
                        <form method="POST" action="{{ route('updatePharmacyProfile', ['userId' => $pharmacy->user_id]) }}">
                            @csrf
                            @method('POST')
                            <div class="form-group row">
                                <label for="status" class="col-sm-1">Status:</label>
                                <div class="col-sm-8">
                                    <label class="switch">
                                        <input type="checkbox" id="statusToggle" name="status" @if($pharmacy->status == 1) checked @endif>
                                        <span class="slider round"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" class="form-control" id="email" name="email" value="{{ $user->email }}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="pharmacyName">Pharmacy Name:</label>
                                <input type="text" class="form-control" id="pharmacyName" name="name" value="{{ $pharmacy->PharmaName }}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="license">Pharmacy License:</label>
                                <input type="text" class="form-control" id="license" name="license" value="{{ $pharmacy->PharmaLicense }}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="pharmacistName">Pharmacist Name:</label>
                                <input type="text" class="form-control" id="pharmacistName" name="pharmacistName" value="{{ $pharmacy->pharmacistName }}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="address">Address:</label>
                                <input type="text" class="form-control" id="address" name="address" value="{{ $pharmacy->Address }}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="phoneNumber">Phone Number:</label>
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNum" value="{{ $pharmacy->PhoneNum }}">
                            </div>


                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        <!-- End of Main Content -->
        
    </div>
    <!-- End of Content Wrapper -->
    
    @include('admin/footer')
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

</body>

