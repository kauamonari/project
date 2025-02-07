/*
  # Create initial users and profiles

  1. New Users
    - Manager user (khelfk31@gmail.com)
    - Employee user (funcionariok31@gmail.com)
  2. Security
    - Users are created with hashed passwords
    - Profiles are created with appropriate roles
*/

-- Create users through Supabase's auth.create_user function
DO $$
DECLARE
  manager_id uuid;
  employee_id uuid;
BEGIN
  -- Create manager user
  SELECT id INTO manager_id FROM auth.users WHERE email = 'khelfk31@gmail.com';
  IF manager_id IS NULL THEN
    SELECT id INTO manager_id FROM auth.create_user(
      'khelfk31@gmail.com',
      'admin123',
      '{}'::jsonb,
      '{}'::jsonb,
      'authenticated',
      'authenticated',
      true,
      null,
      null,
      false,
      null
    );
  END IF;

  -- Create employee user
  SELECT id INTO employee_id FROM auth.users WHERE email = 'funcionariok31@gmail.com';
  IF employee_id IS NULL THEN
    SELECT id INTO employee_id FROM auth.create_user(
      'funcionariok31@gmail.com',
      'fun123',
      '{}'::jsonb,
      '{}'::jsonb,
      'authenticated',
      'authenticated',
      true,
      null,
      null,
      false,
      null
    );
  END IF;

  -- Create manager profile if it doesn't exist
  INSERT INTO user_profiles (id, role, name)
  VALUES (manager_id, 'manager', 'Gerente Khelf')
  ON CONFLICT (id) DO NOTHING;

  -- Create employee profile if it doesn't exist
  INSERT INTO user_profiles (id, role, name)
  VALUES (employee_id, 'employee', 'Funcionário Khelf')
  ON CONFLICT (id) DO NOTHING;
END $$;