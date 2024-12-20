<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    /**
     * Register a new user.
     */
    public function register(Request $request)
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|string|email|unique:users,email',
                'password' => 'required|string|min:6',
                'phone' => 'nullable|string|max:15',
                'profile_image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
                'district' => 'nullable|string',
            ]);

            $profile_image_path = null;
            if ($request->hasFile('profile_image')) {
                $profile_image_path = $request->file('profile_image')->store('profile-images', 'public');
            }

            $user = User::create([
                'name' => $validated['name'],
                'email' => $validated['email'],
                'password' => Hash::make($validated['password']),
                'phone' => $validated['phone'] ?? null,
                'profile_image' => $profile_image_path,
                'district' => $validated['district'] ?? null,
            ]);

            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'user' => $user, 
                'token' => $token,
                'profile_image_url' => $profile_image_path ? asset('storage/' . $profile_image_path) : null
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Registration failed',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Login an existing user.
     */
    public function login(Request $request)
    {
        try {
            $credentials = $request->validate([
                'email' => 'required|string|email|exists:users,email|max:255',
                'password' => 'required|string|min:6',
            ]);

            if (!Auth::attempt($credentials)) {
                return response()->json([
                    'message' => 'Invalid credentials',
                    'errors' => ['email' => ['The provided credentials are incorrect.']]
                ], 401);
            }

            $user = Auth::user();
            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'user' => $user, 
                'token' => $token,
                'profile_image_url' => $user->profile_image ? asset('storage/' . $user->profile_image) : null
            ], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        }
    }

    /**
     * Change the password of the authenticated user.
     */
    public function changePassword(Request $request)
    {
        $validated = $request->validate([
            'current_password' => 'required|string',
            'new_password' => 'required|string|min:6|confirmed',
        ]);

        $user = Auth::user();

        if (!Hash::check($validated['current_password'], $user->password)) {
            return response()->json(['message' => 'Current password is incorrect'], 400);
        }

        $user->update(['password' => Hash::make($validated['new_password'])]);

        return response()->json(['message' => 'Password updated successfully'], 200);
    }

    /**
     * Logout the authenticated user.
     */
    public function logout()
    {
        $user = Auth::user();

        // Revoke all tokens for the user
        $user->tokens()->delete();

        return response()->json(['message' => 'Logged out successfully'], 200);
    }
}
