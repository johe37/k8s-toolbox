FROM debian:bookworm-20260421-slim

ARG KUBECTL_VERSION=v1.30.5
ARG TARGETARCH=amd64

ENV KUBECTL_VERSION=${KUBECTL_VERSION}

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    bash \
    git \
    jq \
    tar \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------
# kubectl (PLATFORM AWARE)
# ----------------------------
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" \
    && install -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# ----------------------------
# helm
# ----------------------------
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# ----------------------------
# helm plugins: diff + secrets
# ----------------------------
RUN helm plugin install https://github.com/databus23/helm-diff || true
RUN helm plugin install https://github.com/jkroepke/helm-secrets || true

# ----------------------------
# helmfile (prebuilt binary)
# ----------------------------
RUN curl -Lo helmfile.tar.gz \
    https://github.com/helmfile/helmfile/releases/download/v1.4.4/helmfile_1.4.4_linux_${TARGETARCH}.tar.gz \
    && tar -xzf helmfile.tar.gz \
    && mv helmfile /usr/local/bin/helmfile \
    && rm -f helmfile.tar.gz

# ----------------------------
# sops (PLATFORM AWARE)
# ----------------------------
RUN curl -Lo /usr/local/bin/sops \
    https://github.com/getsops/sops/releases/download/v3.12.2/sops-v3.12.2.linux.${TARGETARCH} \
    && chmod +x /usr/local/bin/sops

# ----------------------------
# age (PLATFORM AWARE)
# ----------------------------
RUN curl -Lo age.tar.gz \
    https://github.com/FiloSottile/age/releases/latest/download/age-v1.3.1-linux-${TARGETARCH}.tar.gz \
    && tar -xzf age.tar.gz \
    && mv age/age /usr/local/bin/ \
    && mv age/age-keygen /usr/local/bin/ \
    && rm -rf age.tar.gz age

ENTRYPOINT ["bash"]
