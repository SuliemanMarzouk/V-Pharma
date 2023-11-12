<?php
use App\Http\Controllers\MedicineController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

//can't go to any route in this group until you sign in
Route::middleware(['auth'])->group(function () {

    Route::get('/', function () {
        return view('welcome');
    });

});

Route::middleware(['auth', 'Admin'])->group(function () {

    Route::get('/adminDashboard', [App\Http\Controllers\AdminController::class, 'dashboard'])->name('admin.dashboard');
    
    Route::get('/new_pharmacy', [App\Http\Controllers\PharmacyController::class, 'newPharmacy'])->name('new_pharmacy');
    Route::post('/createPharmacy', [App\Http\Controllers\PharmacyController::class, 'store'])->name('pharmacy.store');
    
    Route::get('/new_warehouse', [App\Http\Controllers\WarehouseController::class, 'newWarehouse'])->name('new_warehouse');
    Route::post('/createwarehouse', [App\Http\Controllers\WarehouseController::class, 'store'])->name('warehouse.store');
    
    Route::get('/new_delivery', [App\Http\Controllers\DeliveryController::class, 'newDelivery'])->name('new_delivery');
    Route::post('/createDelivery', [App\Http\Controllers\DeliveryController::class, 'store'])->name('delivery.store');

    Route::get('/deliveries_table', [App\Http\Controllers\DeliveryController::class, 'show'])->name('deliveries_table');

    Route::get('/pharmacies_table', [App\Http\Controllers\PharmacyController::class, 'show'])->name('pharmacy_table');

    Route::get('/warehouses_table', [App\Http\Controllers\WarehouseController::class, 'showWHadmin'])->name('warehouse_table');

    Route::get('/orders_to_delivery', [App\Http\Controllers\orderToDeliveryController::class, 'show'])->name('orders_to_delivery');

    Route::post('/pharmacyOrders/{pharmacyOrderId}/updateDelivery', [App\Http\Controllers\orderToDeliveryController::class, 'updateDeliveryPhOrder'])->name('updateDeliveryPhOrder');
    Route::post('/cusotmerOrders/{customerOrderId}/updateDelivery', [App\Http\Controllers\orderToDeliveryController::class, 'updateDeliveryCusOrder'])->name('updateDeliveryCusOrder');

    
});

Route::middleware(['auth', 'Pharmacy'])->group(function () {

    Route::get('/pharmacyDashboard', [App\Http\Controllers\PharmacyController::class, 'dashboard'])->name('pharmacy.dashboard');

    Route::get('/pharmacyMed', [App\Http\Controllers\PharmacyController::class, 'showPharmaMed'])->name('pharmacyMed');

    Route::get('/warehouses', [App\Http\Controllers\WarehouseController::class, 'show'])->name('warehouses');

    Route::get('/warehouse/{id}', [App\Http\Controllers\WarehouseController::class, 'showWarehouse'])->name('warehouse.show');

    Route::post('/pharma/store-medicine', [App\Http\Controllers\MedicineController::class, 'store']);
    
    Route::put('pharma/medicines/{medicine}', [App\Http\Controllers\MedicineController::class, 'update'])->name('pharmamedicines.update');
    
    Route::get('pharma/order_to_admin', [App\Http\Controllers\orderToAdminController::class, 'show'])->name('order_to_admin');

    Route::get('myOrders', [App\Http\Controllers\PharmacyController::class, 'myOrders'])->name('myOrders');
    Route::post('/accept-order/{order_id}',[App\Http\Controllers\PharmacyController::class,'acceptOrder']);
    Route::post('/reject-order/{order_id}',[App\Http\Controllers\PharmacyController::class,'rejectOrder']);

    Route::delete('pharma/medicines/{id}', [App\Http\Controllers\MedicineController::class, 'destroy'])->name('pharmamedicines.destroy');

    Route::post('warehouse/{id}/order', [App\Http\Controllers\PharmacyOrderController::class, 'store'])->name('pharmacy_orders.store');

    Route::get('profile/{userId}', [App\Http\Controllers\PharmacyController::class, 'pharmacyProfile'])->name('pharmacyProfile');
    Route::post('profile/update/{userId}', [App\Http\Controllers\PharmacyController::class, 'updatePharmacyProfile'])->name('updatePharmacyProfile');
});


Route::middleware(['auth', 'Warehouse'])->group(function () {

    Route::get('/warehouseDashboard', [App\Http\Controllers\WarehouseController::class, 'dashboard'])->name('warehouse.dashboard');

    Route::get('/warehouseMed', [App\Http\Controllers\WarehouseController::class, 'showWarehouseMed'])->name('warehousMed');

    Route::post('/store-medicine', [App\Http\Controllers\MedicineController::class, 'store']);
    
    Route::put('/medicines/{medicine}', [App\Http\Controllers\MedicineController::class, 'update'])->name('medicines.update');
    
    Route::get('/order_to_admin', [App\Http\Controllers\orderToAdminController::class, 'show'])->name('order_to_admin');
    Route::post('/accept-Ph-order/{order_id}',[App\Http\Controllers\WarehouseController::class,'acceptPhOrder']);
    Route::post('/reject-Ph-order/{order_id}',[App\Http\Controllers\WarehouseController::class,'rejectPhOrder']);

    Route::delete('/medicines/{id}', [App\Http\Controllers\MedicineController::class, 'destroy'])->name('medicines.destroy');

    Route::get('profile/warehouse/{userId}', [App\Http\Controllers\WarehouseController::class, 'warehouseProfile'])->name('warehouseProfile');
    Route::post('profile/warehouse/update/{userId}', [App\Http\Controllers\WarehouseController::class, 'updateWarehouseProfile'])->name('updateWarehouseProfile');
});


Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

Route::get('/passwordReset', function () {
    return view('passwordReset');
});
Route::post('/password/update', [App\Http\Controllers\UsersController::class, 'updatePassword'])->name('password.update');
