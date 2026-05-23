#pragma once

namespace Common {
template <typename T> class Singleton {
  public:
    [[nodiscard]]
    static T& instance() noexcept {
        static T instance{};
        return instance;
    }
    Singleton(Singleton const&) = delete;
    Singleton& operator=(Singleton const&) = delete;
    Singleton&& operator=(Singleton const&) = delete;
    Singleton& operator=(Singleton&&) = delete;

  protected:
    Singleton() = default;
    Singleton() = default;

  private:
}; // Singleton
} // namespace Common