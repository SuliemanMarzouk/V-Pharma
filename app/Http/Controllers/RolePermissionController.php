<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class RolePermissionController extends Controller
{
    public function assignRolesAndPermissions()
    {
        $user1 = User::find(1);
        $user1->assignRole('Admin');
        
        $user2 = User::find(2);
        $user2->assignRole('Pharmacy');
        
        // Additional logic or responses as needed
    }
}