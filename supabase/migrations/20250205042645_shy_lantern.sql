/*
  # Create initial users and profiles

  1. New Users
    - Manager user (khelfk31@gmail.com)
    - Employee user (funcionariok31@gmail.com)
  2. Security
    - Users are created with hashed passwords
    - Profiles are created with appropriate roles
*/

-- Create manager user
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at,
  confirmation_token,
  email_change_token_current,
  email_change_token_new,
  recovery_token
) VALUES (
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'khelfk31@gmail.com',
  crypt('admin123', gen_salt('bf')),
  now(),
  now(),
  now(),
  '',
  '',
  '',
  ''
) ON CONFLICT (email) DO NOTHING;

-- Create employee user
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at,
  confirmation_token,
  email_change_token_current,
  email_change_token_new,
  recovery_token
) VALUES (
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'funcionariok31@gmail.com',
  crypt('fun123', gen_salt('bf')),
  now(),
  now(),
  now(),
  '',
  '',
  '',
  ''
);

-- Create manager profile
INSERT INTO user_profiles (id, role, name)
SELECT id, 'manager', 'Gerente Khelf'
FROM auth.users
WHERE email = 'khelfk31@gmail.com';

-- Create employee profile
INSERT INTO user_profiles (id, role, name)
SELECT id, 'employee', 'Funcionário Khelf'
FROM auth.users
WHERE email = 'funcionariok31@gmail.com';