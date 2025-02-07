import React, { useState } from 'react';
import { Menu, LogOut, Home, Settings, User, ChevronLeft, ChevronRight } from 'lucide-react';
import { AuthProvider, useAuth } from './contexts/AuthContext';
import { LoginForm } from './components/LoginForm';

function Dashboard() {
  const { isManager, signOut, profile } = useAuth();
  const [isSidebarOpen, setSidebarOpen] = useState(true);
  const [tasks, setTasks] = useState([
    { id: 1, text: 'Colocar preço', completed: false },
    { id: 2, text: 'Arrumar sessão', completed: false },
    { id: 3, text: 'Verificar emails importantes', completed: false },
    { id: 4, text: 'Fazer feedback', completed: false },
  ]);

  const toggleTask = (id: number) => {
    setTasks(tasks.map(task => 
      task.id === id ? { ...task, completed: !task.completed } : task
    ));
  };

  // Define which menu items are available based on role
  const sidebarItems = [
    { id: 'dashboard', text: 'Dashboard', access: 'all' },
    { id: 'reports', text: 'Relatórios', access: 'all' },
    { id: 'projects', text: 'Projetos', access: 'all' },
    { id: 'team', text: 'Equipe', access: 'all' },
  ].filter(item => item.access === 'all' || (item.access === 'manager' && isManager));

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="fixed top-0 w-full bg-emerald-600 text-white shadow-lg z-50 ">
        <div className="container mx-auto px-4 py-4 ">
          <h1 className="text-3xl font-bold text-center ">K H E L F</h1>
        </div>
      </header>

      {/* Menu Bar */}
      <nav className="fixed top-16 w-full bg-white shadow-md z-40">
        <div className="container mx-auto px-4 py-2 flex justify-between items-center">
          <div className="flex gap-6">
            <a href="#" className="flex items-center gap-2 text-gray-700 hover:text-emerald-600">
              <Home size={20} />
              <span>Início</span>
            </a>
            <a href="#" className="flex items-center gap-2 text-gray-700 hover:text-emerald-600">
              <Settings size={20} />
              <span>Configurações</span>
            </a>
            <a href="#" className="flex items-center gap-2 text-gray-700 hover:text-emerald-600">
              <User size={20} />
              <span>{profile?.name}</span>
            </a>
          </div>
          <button
            onClick={signOut}
            className="flex items-center gap-2 text-red-600 hover:text-red-700"
          >
            <LogOut size={20} />
            <span>Sair</span>
          </button>
        </div>
      </nav>

      {/* Main Content */}
      <div className="pt-32 flex min-h-screen">
        {/* Sidebar */}
        <aside className={`fixed left-0 h-full bg-gray-100 shadow-lg transition-all duration-300 ${
          isSidebarOpen ? 'w-64' : 'w-16'
        }`}>
          <button
            onClick={() => setSidebarOpen(!isSidebarOpen)}
            className="absolute -right-3 top-4 bg-white rounded-full p-1 shadow-md"
          >
            {isSidebarOpen ? <ChevronLeft size={20} /> : <ChevronRight size={20} />}
          </button>
          <div className="p-4 space-y-3">
            {sidebarItems.map((item) => (
              <button
                key={item.id}
                className="w-full text-left px-4 py-3 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors"
              >
                {isSidebarOpen ? item.text : item.text[0]}
              </button>
            ))}
          </div>
        </aside>

        {/* Main Content Area */}
        <main className={`flex-1 transition-all duration-300 ${
          isSidebarOpen ? 'ml-64' : 'ml-16'
        }`}>
          <div className="container mx-auto px-6 py-8">
            <h2 className="text-2xl font-semibold text-gray-800 mb-6">Checklist Diário</h2>
            <div className="bg-white rounded-lg shadow-md p-6">
              <div className="space-y-4">
                {tasks.map(task => (
                  <div key={task.id} className="flex items-center space-x-3">
                    <input
                      type="checkbox"
                      checked={task.completed}
                      onChange={() => toggleTask(task.id)}
                      className="w-5 h-5 text-emerald-600 rounded focus:ring-emerald-500"
                    />
                    <label className={`text-gray-700 ${task.completed ? 'line-through text-gray-400' : ''}`}>
                      {task.text}
                    </label>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}

function App() {
  return (
    <AuthProvider>
      <AppContent />
    </AuthProvider>
  );
}

function AppContent() {
  const { user } = useAuth();
  return user ? <Dashboard /> : <LoginForm />;
}

export default App;