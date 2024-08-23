/*
 * Copyright (C) 2022 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "SunlightEnhancementService"

#include <fstream>
#include <android-base/file.h>
#include <android-base/logging.h>
#include <android-base/strings.h>

#include "SunlightEnhancement.h"

namespace vendor {
namespace lineage {
namespace livedisplay {
namespace V2_1 {
namespace implementation {

static constexpr const char *kHbmStatePath = "/sys/devices/platform/common_node/hbmstate";
static constexpr const char *kBrightnessPath = "/sys/devices/platform/14013000.dsi/hbm";

bool SunlightEnhancement::isSupported() {
    std::ofstream hbm_file(kHbmStatePath);
    if (!hbm_file.is_open()) {
        LOG(ERROR) << "Failed to open " << kHbmStatePath << ", error=" << errno
                   << " (" << strerror(errno) << ")";
    }
    return !hbm_file.fail();
}

Return<bool> SunlightEnhancement::isEnabled() {
    std::ifstream hbm_file(kHbmStatePath);
    int result = -1;
    hbm_file >> result;
    return !hbm_file.fail() && result > 0;
}

Return<bool> SunlightEnhancement::setEnabled(bool enabled) {
    std::ofstream brightness_file(kBrightnessPath);
    brightness_file << (enabled ? "1" : "0");
    if (brightness_file.fail())
        LOG(ERROR) << "Failed to write " << kBrightnessPath;
    return !brightness_file.fail();
}

}  // namespace implementation
}  // namespace V2_1
}  // namespace livedisplay
}  // namespace lineage
}  // namespace vendor
