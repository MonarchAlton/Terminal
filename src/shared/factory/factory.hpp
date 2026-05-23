#pragma once

#include <memory>
#include <new>
#include <utility>

#include "../singleton/singleton.hpp"

namespace Common {

template <typename> inline constexpr bool dependent_false_v = false;

/**
 * @brief Generic singleton-backed object factory.
 *
 * Provides controlled construction for types with private or protected
 * constructors. Types constructed by this factory must declare Common::Factory
 * as a friend.
 *
 * Construction is split into two paths:
 *
 * - create<T>() for constructors that may throw.
 * - create_nothrow<T>() for constructors marked noexcept.
 *
 * If create<T>() is called for a noexcept-constructible type, compilation fails
 * with a diagnostic telling the caller to use create_nothrow<T>() instead.
 */
class Factory final : public Singleton<Factory> {
    friend class Singleton<Factory>;

  public:
    /**
     * @brief Creates an object whose selected constructor may throw.
     *
     * This overload is only available when T can be constructed from Args, but
     * that construction is not noexcept.
     *
     * @tparam T The type to create.
     * @tparam Args Constructor argument types.
     *
     * @param args Arguments forwarded to T's constructor.
     *
     * @return A std::unique_ptr owning the newly constructed object.
     *
     * @throws std::bad_alloc If allocation fails.
     * @throws Any exception thrown by T's constructor.
     */
    template <typename T, typename... Args>
        requires(can_construct<T, Args...>() && !can_construct_nothrow<T, Args...>())
    [[nodiscard]]
    std::unique_ptr<T> create(Args&&... args) {
        return std::unique_ptr<T>{new T{std::forward<Args>(args)...}};
    }

    /**
     * @brief Rejects create<T>() for noexcept-constructible types.
     *
     * This overload intentionally fails compilation when the caller uses
     * create<T>() for a type that should be created through create_nothrow<T>().
     */
    template <typename T, typename... Args>
        requires can_construct_nothrow<T, Args...>
    () [[nodiscard]] std::unique_ptr<T> create(Args&&...) {
        static_assert(dependent_false_v<T>,
                      "Common::Factory::create<T>() was called for a noexcept-constructible type. "
                      "Use Common::Factory::create_nothrow<T>() instead.");

        return nullptr;
    }

    /**
     * @brief Creates an object using a noexcept constructor.
     *
     * This overload is only available when T can be constructed from Args without
     * throwing.
     *
     * Allocation uses std::nothrow, so allocation failure returns nullptr instead
     * of throwing std::bad_alloc.
     *
     * @tparam T The type to create.
     * @tparam Args Constructor argument types.
     *
     * @param args Arguments forwarded to T's constructor.
     *
     * @return A std::unique_ptr owning the constructed object, or nullptr if
     *         allocation fails.
     */
    template <typename T, typename... Args>
        requires can_construct_nothrow<T, Args...>
    () [[nodiscard]] std::unique_ptr<T> create_nothrow(Args&&... args) noexcept {
        return std::unique_ptr<T>{new (std::nothrow) T{std::forward<Args>(args)...}};
    }

  private:
    Factory() = default;

    template <typename T, typename... Args> static consteval bool can_construct() {
        return requires(Args&&... args) { T{std::forward<Args>(args)...}; };
    }

    template <typename T, typename... Args> static consteval bool can_construct_nothrow() {
        return requires(Args&&... args) {
            {
                T {
                    std::forward<Args>(args)...
                }
            } noexcept;
        };
    }
};

} // namespace Common